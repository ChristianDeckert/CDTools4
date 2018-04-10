import Foundation
import UIKit
import QuartzCore


public extension UIView {
    
    public enum Animations {
        case none
        case fade(duration: TimeInterval)
        case pushFromBottom(duration: TimeInterval)
        case springAnimation(duration: TimeInterval)
        case scale(duration: TimeInterval)
        
        public var isAnimated: Bool {
            switch self {
            case .none: return false
            default: return true
            }
        }
        
        public var isFade: Bool {
            switch self {
            case .fade: return true
            default: return false
            }
        }
        
        public var isPushFromBottom: Bool {
            switch self {
            case .pushFromBottom: return true
            default: return false
            }
        }
        
        public var isSpringAnimation: Bool {
            switch self {
            case .springAnimation: return true
            default: return false
            }
        }
        
        public var isScaleAnimation: Bool {
            switch self {
            case .springAnimation: return true
            default: return false
            }
        }
        
        public static var preferredSpringAnimationDuration: TimeInterval = 0.5
        public static var preferredAnimationDuration: TimeInterval = 0.3
        public static var preferredDamping: CGFloat = 0.45
        public static var preferredMinimumScaleTransformation: CGAffineTransform = CGAffineTransform(scaleX: 0.01, y: 0.01)
    }
    
    public var className: String {
        return String(describing: type(of: self))
    }
    
    public class var className: String {
        return String(describing: self)
    }
    
    public class var reuseIdentifier: String {
        return className
    }
    
    public class var nibName: String {
        return className
    }
    
    public static func new<T: UIView>(bundle: Bundle = Bundle.main) -> T {
        return bundle.loadNibNamed(self.className, owner: nil, options: nil)?.first as! T
    }
    
    public func animate(in viewAnimation: Animations, fromCurrentState: Bool = true, completion: ((_ complete: Bool) -> Void)? = nil) {
        switch viewAnimation {
        case .none:
            if !fromCurrentState {
                alpha = 0
            }
            alpha = 1
            completion?(true)
        case .pushFromBottom(let duration):
            if !fromCurrentState {
                transform = CGAffineTransform(translationX: 0, y: bounds.height)
                alpha = 1
            }
            UIView.animate(withDuration: duration, animations: {
                self.transform = .identity
            }, completion: completion)
            
        case .fade(let duration):
            if !fromCurrentState {
                alpha = 0
            }
            UIView.animate(withDuration: duration, animations: {
                self.alpha = 1
            }, completion: completion)
            
        case .scale(let duration):
            if !fromCurrentState {
                transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                alpha = 1
            }
            UIView.animate(withDuration: duration, animations: {
                self.transform = .identity
                self.alpha = 1
            }, completion: completion)
            
        case .springAnimation(let duration):
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: Animations.preferredDamping, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                self.transform = .identity
                self.alpha = 1
            }, completion: completion)
            
        }
    }
    
    public func animate(out viewAnimation: Animations, completion: ((_ complete: Bool) -> Void)? = nil) {
        switch viewAnimation {
        case .none:
            alpha = 0
            completion?(true)
        case .pushFromBottom(let duration):
            UIView.animate(withDuration: duration, animations: {
                self.transform = CGAffineTransform(translationX: 0, y: self.bounds.height)
            }, completion: completion)
        case .scale(let duration):
            UIView.animate(withDuration: duration, animations: {
                self.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            }, completion: completion)
        case .fade(let duration):
            alpha = 1
            UIView.animate(withDuration: duration, animations: {
                self.alpha = 0
            }, completion: completion)
        case .springAnimation(let duration):
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: Animations.preferredDamping, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                self.transform = Animations.preferredMinimumScaleTransformation
                self.alpha = 0
            }, completion: completion)
        }
    }
}

public extension UIView {
    
    public convenience init(backgroundColor: UIColor) {
        self.init()
        self.backgroundColor = backgroundColor
    }
    
    @discardableResult public func addVerticalGradient(topColor top: UIColor, bottomColor bottom: UIColor) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [top.cgColor, bottom.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        self.layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }
    
    @discardableResult public func addVerticalGradient(colors: [CGColor], locations: [NSNumber]) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors
        gradientLayer.locations = locations
        self.layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }
    
    public func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) -> CALayer? {
        
        let borderLayer = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            borderLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
            
        case UIRectEdge.bottom:
            borderLayer.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
            
        case UIRectEdge.left:
            borderLayer.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
            
        case UIRectEdge.right:
            borderLayer.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
            
        default:
            break
        }
        
        borderLayer.backgroundColor = color.cgColor
        
        layer.addSublayer(borderLayer)
        
        return layer
    }
    
    public func addDropShadow(shadowRadius: CGFloat = 4.0, shadowOpacity: Float = 0.75, shadowOffset: CGSize = CGSize(width: 0, height: 0)) {
        self.clipsToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = shadowOffset
    }
    
    
    /**
     Removes all subviews of a given (generic) type.
     
     - Parameters:
     - animation: an dismissal animation (see NightingaleAnimation)
     - tagFilter: an optional filter for specific view tags to be removed
     - completion: optional completion
     
     Note: the type is inferred by the caller
     
     Example:
     let arrayOfViews: [MyFancyViewClass] = self.removeSubviewsOfType
     */
    @discardableResult public func removeSubviewsOfType<T: UIView>(tagFilter: Int? = nil) -> [T] {
        
        let allSubviews: [T] = subviewsOfType(tagFilter: tagFilter)
        for subview in allSubviews {
            subview.removeFromSuperview()
        }
        
        return allSubviews
    }
    
    @discardableResult public func subviewsOfType<T: UIView>(tagFilter: Int? = nil) -> [T] {
        
        var removedSubviews = [T]()
        for subview in subviews {
            guard let viewWithGivenType = subview as? T else { continue }
            if let tagFilter = tagFilter, subview.tag == tagFilter {
                removedSubviews.append(viewWithGivenType)
            } else if tagFilter == nil {
                removedSubviews.append(viewWithGivenType)
            }
        }
        return removedSubviews
    }
    
    @discardableResult func addGradient(frame: CGRect, color: UIColor, at index: UInt32 = 0, locations: [NSNumber] = [0.0, 1.0]) -> CAGradientLayer {
        let colorTop = color.withAlphaComponent(0).cgColor
        let colorBottom = color.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = locations
        gradientLayer.frame = frame
        layer.insertSublayer(gradientLayer, at: index)
        return gradientLayer
    }
}
