import Foundation
import UIKit

@IBDesignable
public class AnimatedButton: UIButton {
    
    @IBInspectable public var scaleFactor: CGFloat = 0.9
    @IBInspectable public var animationDuration: TimeInterval = 0.3
    @IBInspectable public var shouldAnimate: Bool = true
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if nil == superview  {
            removeTarget(self, action: #selector(touchDown), for: .touchDown)
            removeTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
            removeTarget(self, action: #selector(touchUpInside), for: .touchUpOutside)
            removeTarget(self, action: #selector(touchUpInside), for: .touchDragOutside)
        } else {
            addTarget(self, action: #selector(touchDown), for: .touchDown)
            addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
            addTarget(self, action: #selector(touchUpInside), for: .touchUpOutside)
            addTarget(self, action: #selector(touchUpInside), for: .touchDragOutside)
        }
    }
    
    
    @IBAction public func touchDown() {
        guard shouldAnimate else { return }
        UIView.animate(withDuration: animationDuration, animations: {
            self.transform = CGAffineTransform.init(scaleX: self.scaleFactor, y: self.scaleFactor)
        }, completion: nil)
    }
    
    @IBAction public func touchUpInside() {
        UIView.animate(withDuration: animationDuration, animations: {
            self.transform = .identity
        }, completion: nil)
    }
}
