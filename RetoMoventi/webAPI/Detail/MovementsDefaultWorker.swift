import RxSwift
import MoventiCore

class mockMovementsWorker: MovementsWorker {
    func fetchMovements(numberAccount:String) -> Observable<[MovementModel]> {
        return Observable.create { observer in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let datos = [
                   MovementModel(title: "Compra Tienda", dateLabel: "20 abr 2023", amountLabel: "400.5", noMovements: "4523151321", state: 3),
                   MovementModel(title: "Abono Yape", dateLabel: "20 abr 2023", amountLabel: "1500.45", noMovements: "452315451321", state: 2)

                ]
                observer.onNext(datos)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
