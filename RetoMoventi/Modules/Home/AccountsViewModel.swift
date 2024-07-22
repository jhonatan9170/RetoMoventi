import RxSwift
import RxCocoa
import MoventiCore

class AccountsViewModel: LazyViewModelType{
    var input: Input!
    var output: Output!
    
    private let triggerSubject = ReplaySubject<Void>.create(bufferSize: 1)
    
    init(worker: AccountsWorker,scheduler: ImmediateSchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)) {
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        let accounts = triggerSubject
            .observe(on: scheduler)
            .flatMapLatest {
                worker.fetchAccounts()
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                .asDriverOnErrorJustComplete() }
            .asDriverOnErrorJustComplete()
        
        output = Output(
            accounts: accounts,
            cargando: activityIndicator.asDriver(),
            error: errorTracker.asDriver())
        
        input = Input(triggerSubject: triggerSubject.asObserver())
    }
}

extension AccountsViewModel {
    struct Input {
        let triggerSubject: AnyObserver<Void>
    }
    
    struct Output {
        let accounts: Driver<[AccountModel]>
        let cargando: Driver<Bool>
        let error: Driver<Error>
    }
}

