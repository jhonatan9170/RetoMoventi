

import Foundation

public struct AccountModel {
    public let imageName: String
    public let title: String
    public let currency: String
    public let amount: String
    public let accountNumber: String
    public let copyButton: ButtonStyle
    
    public init(imageName: String, title: String, currency: String, amount: String, accountNumber: String, copyButton: ButtonStyle) {
        self.imageName = imageName
        self.title = title
        self.currency = currency
        self.amount = amount
        self.accountNumber = accountNumber
        self.copyButton = copyButton
    }
}
