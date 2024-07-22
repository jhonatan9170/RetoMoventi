import Foundation

public struct MovementModel {
    
    public let title: String
    public let date: String
    public let amount: String
    public let noMovements: String
    public let state: Int
    public init(title: String, dateLabel: String, amountLabel: String, noMovements: String,state:Int) {
        self.title = title
        self.date = dateLabel
        self.amount = amountLabel
        self.noMovements = noMovements
        self.state = state
    }
}
