import RxSwift
import RxCocoa
import MoventiCore

class MovementsViewModel: LazyViewModelType{
    var input: Input!
    var output: Output!
    
    private let cuentaSubject = ReplaySubject<String>.create(bufferSize: 1)

    
    init(worker: MovementsWorker,scheduler: ImmediateSchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)) {
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        let resultado = cuentaSubject
            .observe(on: scheduler)
            .flatMapLatest {
                worker.fetchMovements(numberAccount: $0)
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                .asDriverOnErrorJustComplete() }
            .asDriverOnErrorJustComplete()
        
        output = Output(
            movements: resultado,
            cargando: activityIndicator.asDriver(),
            error: errorTracker.asDriver())
        
        input = Input(cuentaSubject:cuentaSubject.asObserver())
    }
}

extension MovementsViewModel {
    struct Input {
        let cuentaSubject: AnyObserver<String>
    }
    
    struct Output {
        let movements: Driver<[MovementModel]>
        let cargando: Driver<Bool>
        let error: Driver<Error>
    }
}
