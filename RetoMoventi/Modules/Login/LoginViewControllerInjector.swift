import UIKit

class LoginViewControllerInjector {
    
    static func inject() -> LoginViewController {
        
        let loginViewModel = LoginViewModelInjector.inject()
        let viewController = LoginViewController()
        
        viewController.loginViewModel = loginViewModel
        
        return viewController
    }
    
    
}
