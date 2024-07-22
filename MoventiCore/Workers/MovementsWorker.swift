import RxSwift

public protocol MovementsWorker {
    func fetchMovements(numberAccount:String) -> Observable<[MovementModel]>
}
