
import RxSwift

public protocol LoginWorkerType {
    func login(input: LoginInput) -> Observable<Void>
}
