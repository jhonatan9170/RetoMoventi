import RxSwift
import RxCocoa
import MoventiCore
import DesignSystem

extension DetailViewControlller {
    func configBindings(){
        
        movementViewModel.input.cuentaSubject.onNext(accountModel.accountNumber)
        
        movementViewModel.output.movements
            .drive(
                tableMovimientos.rx.items(
                    cellIdentifier: MovementCardCell.cellIdentifier,
                    cellType: MovementCardCell.self
                )
            ) {
                tv, model, cell in cell.configure(model: model)
            }
            .disposed(by: disposeBag)
        
        movementViewModel.output.cargando
            .drive(loader.rx.isAnimating)
            .disposed(by: disposeBag)
        
        movementViewModel.output.error
            .drive(onNext: { [weak self] error in
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alertController, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        movementViewModel.output.error
            .map{_ in return true}
            .drive(tableMovimientos.rx.isHidden)
            .disposed(by: disposeBag)
        
        
    }
}
