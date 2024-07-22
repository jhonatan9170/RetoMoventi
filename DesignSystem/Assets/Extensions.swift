import Foundation

extension String {
    var formattedAsCurrency: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.decimalSeparator = "."
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        guard let number = Decimal(string: self) else { return nil }
        return formatter.string(from: number as NSDecimalNumber)
    }
}
