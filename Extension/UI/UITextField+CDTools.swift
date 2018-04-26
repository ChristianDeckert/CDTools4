import Foundation
import UIKit

public extension UITextField {
   public  func selectAllText() {
        selectedTextRange = textRange(from: beginningOfDocument, to: endOfDocument)
    }
}
