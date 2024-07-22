import RxSwift
import RxCocoa
import MoventiCore
import DesignSystem

extension HomeProductosViewController {
    
    func configBindings() {
        
        self.accountViewModel.input.triggerSubject.onNext(())
        
        accountViewModel.output.accounts
            .drive(
                tableProductos.rx.items(
                    cellIdentifier: AccountCardCell.cellIdentifier,
                    cellType: AccountCardCell.self
                )
            ) {
                tv, model, cell in cell.cardView.configure(model: model)
            }
            .disposed(by: disposeBag)
        
        accountViewModel.output.accounts
            .drive(onNext: { [weak self] accounts in
                self?.accounts = accounts
            })
            .disposed(by: disposeBag)
        
        accountViewModel.output.cargando
            .drive(loader.rx.isAnimating)
            .disposed(by: disposeBag)

        accountViewModel.output.error.asDriver()
            .drive(onNext: {[weak self] error in
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alertController, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        accountViewModel.output.error.asDriver()
            .map{_ in return true}
            .drive(tableProductos.rx.isHidden)
            .disposed(by: disposeBag)
        
        tableProductos.rx.itemSelected.asDriver()
            .drive(binderIrADetalleMovimiento)
            .disposed(by: disposeBag)
        
    }
    
    private var binderIrADetalleMovimiento : Binder<IndexPath> {
        return Binder(self, binding: {[weak self] (vc, movimientos) in
            
            guard let self else { return }
            
            let indice = movimientos.row
            
            let account = self.accounts[indice]
            let vc = DetailViewControlllerInjector.inject(accountModel: account)
            
            self.navigationController?.pushViewController(vc, animated: true)
        })
    }
}
