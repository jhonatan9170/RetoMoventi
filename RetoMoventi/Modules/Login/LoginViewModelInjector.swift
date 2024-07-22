import Foundation

class LoginViewModelInjector {
    
    static func inject() -> LoginViewModel {
        
        let worker = LoginDefaultWorker()
        
        return LoginViewModel(worker: worker)
    }
    
}
