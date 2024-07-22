import RxSwift
import MoventiCore

class MockAccountWorker: AccountsWorker {

    func fetchAccounts() -> Observable<[AccountModel]> {
        return Observable.create { observer in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let datos = [
                    AccountModel(imageName: "ic_savings_light", title: "Cuenta de Ahorro Soles", currency: "S/ ", amount: "1,000,000", accountNumber: "123456789", copyButton: .outlined),
                    AccountModel(imageName: "ic_savings_usd_light", title: "Cuenta de Ahorro Dolares", currency: "$ ", amount: "2,000,000", accountNumber: "987654321", copyButton: .outlined),
                ]
                observer.onNext(datos)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}

