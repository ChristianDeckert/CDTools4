import Foundation
import UIKit

@IBDesignable
open class  ImageButton: AnimatedButton {
    
    open override var isEnabled: Bool {
        didSet {
            customImageView.alpha = isEnabled ? 1 : 0.5
        }
    }
    
    @IBInspectable open var image: UIImage? {
        get {
            return customImageView.image
        }
        set {
            customImageView.image = newValue
        }
    }
    
    open lazy var customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.embed(in: self, insets: UIEdgeInsetsMake(4, 4, 4, 4))
        imageView.isUserInteractionEnabled = false
        return imageView
    }()
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard nil != superview else { return }
        setTitle(nil, for: .normal)
    }
}
