import UIKit
import MoventiCore

class DetailViewControlllerInjector {
    static func inject(accountModel : AccountModel) -> DetailViewControlller {
        let vc = DetailViewControlller()
        vc.accountModel = accountModel
        vc.movementViewModel = MovementsViewModelInjector.inject()
        return vc
    }
}
