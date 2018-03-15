import Foundation
import UIKit

extension Bundle {

    /* Example: let singleActionView: SingleActionView = Bundle.load(from: NightingaleBottomSheet.self)
    */
    static func load<T: UIView>(from: UIView.Type, bundle: Bundle? = Bundle.main) -> T? {
        for nib in bundle?.loadNibNamed(from.className, owner: nil, options: nil) ?? [] {

            guard let viewOfType = nib as? T else { continue }
            return viewOfType
        }
        return nil
    }
}
