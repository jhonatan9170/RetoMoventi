import RxSwift
import RxCocoa
import MoventiCore

class LoginViewModel: LazyViewModelType{
    var input: Input!
    var output: Output!
    
    private let triggerSubject = ReplaySubject<Void>.create(bufferSize: 1)
    private let inputSubject = ReplaySubject<LoginInput>.create(bufferSize: 1)

    
    init(worker: LoginWorker,scheduler: ImmediateSchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)) {
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        let resultado = inputSubject
            .observe(on: scheduler)
            .flatMapLatest {
                worker.login($0)
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                .asDriverOnErrorJustComplete() }
            .asDriverOnErrorJustComplete()
        
        output = Output(
            validado: resultado,
            cargando: activityIndicator.asDriver(),
            error: errorTracker.asDriver())
        
        input = Input(inputSubject:inputSubject.asObserver())
    }
}

extension LoginViewModel {
    struct Input {
        let inputSubject: AnyObserver<LoginInput>
    }
    
    struct Output {
        let validado: Driver<Void>
        let cargando: Driver<Bool>
        let error: Driver<Error>
    }
}
