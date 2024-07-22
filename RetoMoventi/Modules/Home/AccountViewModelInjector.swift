import RxSwift

class AccountViewModelInjector {
    static func inject() -> AccountsViewModel {
        let worker = MockAccountWorker()
        return AccountsViewModel(worker: worker)
    }
}
