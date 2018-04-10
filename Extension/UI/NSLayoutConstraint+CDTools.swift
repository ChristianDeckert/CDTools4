import UIKit
import Foundation


public extension UIView {
    func embed(in parentView: UIView, insets: UIEdgeInsets = .zero) {
        NSLayoutConstraint.embed(view: self, in: parentView, insets: insets)
    }
}

public extension NSLayoutConstraint {
    @discardableResult public static func embed(view: UIView, in parentView: UIView, insets: UIEdgeInsets = .zero) -> Bool {
        view.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(view)
        
        let leading = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: parentView, attribute: .leading, multiplier: 1.0, constant: insets.left)
        let trailing = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.trailing, relatedBy: .equal, toItem: parentView, attribute: .trailing, multiplier: 1.0, constant: insets.right)
        let top = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: parentView, attribute: .top, multiplier: 1.0, constant: insets.top)
        let bottom = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.bottom, relatedBy: .equal, toItem: parentView, attribute: .bottom, multiplier: 1.0, constant: -insets.bottom)
        let constraints = [top, leading, bottom, trailing]
        parentView.addConstraints(constraints)
    
        return true
    }
}
