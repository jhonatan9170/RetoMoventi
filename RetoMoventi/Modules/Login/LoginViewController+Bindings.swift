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
            .drive(onNext: { [weak self] error in
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alertController, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        loginViewModel.output.cargando
            .drive(loader.rx.isAnimating)
            .disposed(by: disposeBag)
        

        passwordField.textField.rx.text
            .map{[weak self] _ in
                let validpass = self?.passwordField.validatePassword() ?? false
                let validuser = self?.emailField.validateEmail() ?? false
                return validpass&&validuser
            }
            .asDriverOnErrorJustComplete()
            .drive(loginButton.rx.isEnabled)
            .disposed(by: disposeBag)



    }
    
    private func getLoginInput() -> LoginInput {
        if let correo = getCorreo(){
            return LoginInput(email: correo, password: passwordField.textField.text ?? "")
        }
        return LoginInput(email: emailField.textField.text ?? "", password: passwordField.textField.text ?? "")
    }
    
    private var goToHome: Binder<Void> {
        return Binder(self, binding: { [weak self] (vc, _) in
            let vc = HomeProductosViewControllerInjector.inject()
            SessionManager.shared.start()
            self?.navigationController?.pushViewController(vc, animated: true)
        })
    }
     func getCorreo()->String?{
        return UserDefaultMananger.shared.get(key: Constants.correKey, type: String.self)
    }
    
    func getUser()->String?{
        return UserDefaultMananger.shared.get(key: Constants.userKey, type: String.self)
    }
}
