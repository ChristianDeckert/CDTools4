import Foundation
import UIKit

public func dismissKeyboard() {
    //UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
    UIApplication.shared.keyWindow?.endEditing(true)
}

