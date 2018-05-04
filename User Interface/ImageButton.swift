import Foundation
import UIKit

@IBDesignable
open class  ImageButton: AnimatedButton {
    
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
        imageView.embed(in: self)
        imageView.isUserInteractionEnabled = false
        return imageView
    }()
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard nil != superview else { return }
        setTitle(nil, for: .normal)
    }
}
