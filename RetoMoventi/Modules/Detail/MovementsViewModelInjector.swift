import RxSwift

class MovementsViewModelInjector{
    static func inject() -> MovementsViewModel {
        let worker = mockMovementsWorker()
        return MovementsViewModel(worker: worker)
    }
}
