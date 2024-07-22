import RxSwift
import RxCocoa
import MoventiCore
extension LoginViewController {
    func configBindings() {
        loginButton.rx.tap.asDriver()
            .map{ [weak self] in
                guard let self = self else { return LoginInput(email: "", password: "") }
                return self.getLoginInput()}
            .drive(loginViewModel.input.inputSubject)
            .disposed(by: disposeBag)
        
        loginViewModel.output.validado
            .drive(goToHome)
            .disposed(by: disposeBag)
        
        loginViewModel.output.error
            .map{ _ in 
                print("falla")
            }
            .drive()
            .disposed(by: disposeBag)
        
        loginViewModel.output.cargando
            .drive(loader.rx.isAnimating)
            .disposed(by: disposeBag)
        
        let validarEmailObserver = emailField.textField.rx.text
            .map{[weak self] _ in self?.emailField.validateEmail() ?? false}
            .asDriverOnErrorJustComplete()
        let validarPasswordObserver = passwordField.textField.rx.text
            .map{[weak self] _ in self?.passwordField.validatePassword() ?? false}
            .asDriverOnErrorJustComplete()

        Driver.combineLatest(validarEmailObserver, validarPasswordObserver)
            .map{ $0 && $1 }
            .drive(loginButton.rx.isEnabled)
            .disposed(by: disposeBag)

    }
    
    private func getLoginInput() -> LoginInput {
        return LoginInput(email: emailField.textField.text ?? "", password: passwordField.textField.text ?? "")
    }
    
    private var goToHome: Binder<Void> {
        return Binder(self, binding: { [weak self] (vc, _) in
            let vc = HomeProductosViewControllerInjector.inject()
            self?.navigationController?.pushViewController(vc, animated: true)
        })
    }
}
