import Foundation

public protocol LazyViewModelType {
    associatedtype Input
    associatedtype Output

    var input: Input! { get }
    var output: Output! { get }
}
