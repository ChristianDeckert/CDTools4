import Foundation
import UIKit
import QuartzCore


public extension UIView {
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
}

// MARK: - Storyboard Helpers

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
