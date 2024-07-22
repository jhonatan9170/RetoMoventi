
import RxSwift

public protocol LoginWorker {
    func login(_ input: LoginInput) -> Observable<Void>
}
