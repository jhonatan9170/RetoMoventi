
import Foundation

class HomeProductosViewControllerInjector {
    static func inject() -> HomeProductosViewController{
        let vc = HomeProductosViewController()
        vc.accountViewModel = AccountViewModelInjector.inject()
        return vc
    }
}
