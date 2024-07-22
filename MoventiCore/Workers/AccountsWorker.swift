import RxSwift

public protocol AccountsWorker {
    func fetchAccounts() -> Observable<[AccountModel]>
}
