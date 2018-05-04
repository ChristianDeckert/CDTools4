import Foundation
import StoreKit

public extension SKProduct {
    
    public var localizedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        return formatter.string(from: self.price) ?? ""
    }
    
}
