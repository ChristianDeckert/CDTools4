import UIKit
import Foundation

public extension UIViewController {
    
    public convenience init(backgroundColor: UIColor) {
        self.init()
        view.backgroundColor = backgroundColor
    }
}

public extension UIViewController {
    public var className: String {
        return String(describing: type(of: self))
    }
    
    public class var className: String {
        return String(describing: self)
    }
    
    public class var nibName: String {
        return className
    }
    
    public static func new<T: UIViewController>(bundle: Bundle? = Bundle.main) -> T {
        return bundle?.loadNibNamed(self.className, owner: nil, options: nil)?.first as! T
    }
}

public extension UIViewController {
    static var topMostViewController: UIViewController? {
        return topViewController()
    }
    
    static var root: UIViewController? {
        return UIApplication.shared.delegate?.window??.rootViewController
    }
    
    static func topViewController(in viewController: UIViewController? = nil) -> UIViewController? {
        guard var topViewController = (viewController ?? root) else { return nil }
        
        func presentedRecursive(of parentViewController: UIViewController) -> UIViewController {
            if let navVC = parentViewController as? UINavigationController, let navTopVc = navVC.topViewController { // navigation controller
                return presentedRecursive(of: navTopVc)
            } else if let tabVC = parentViewController as? UITabBarController, let selectedVc = tabVC.selectedViewController { // tab controller
                return presentedRecursive(of: selectedVc)
            } else if let presentedVC = parentViewController.presentedViewController { // modals
                return presentedRecursive(of: presentedVC)
            } else {
                return parentViewController
            }
        }
        
        return presentedRecursive(of: topViewController)
    }
    
    public func add(childViewController: UIViewController, animation: UIView.Animations, embed: Bool = true, insets: UIEdgeInsets = .zero, duration: TimeInterval = 0.3, complete: (() -> Void)? = nil) {
        childViewController.willMove(toParent: self)
        childViewController.beginAppearanceTransition(true, animated: animation.isAnimated)
        
        childViewController.view.alpha = 0
        if embed {
            NSLayoutConstraint.embed(view: childViewController.view, in: view, insets: insets)
        } else {
            view.addSubview(childViewController.view)
        }
        
        if animation.isAnimated {
            childViewController.view.animate(in: animation, fromCurrentState: false, completion: { _ in
                self.addChild(childViewController)
                childViewController.endAppearanceTransition()
                childViewController.didMove(toParent: self)
                complete?()
            })
        } else {
            childViewController.view.alpha = 1
            self.addChild(childViewController)
            childViewController.endAppearanceTransition()
            childViewController.didMove(toParent: self)
            DispatchQueue.main.async { complete?() }
        }
    }
    
    public func remove(childViewController: UIViewController, animation: UIView.Animations = .none, complete: (() -> Void)? = nil) {
        childViewController.willMove(toParent: nil)
        childViewController.beginAppearanceTransition(false, animated: animation.isAnimated)
        
        let localCompletion: (Bool) -> Void = { _ in
            childViewController.view.removeFromSuperview()
            childViewController.endAppearanceTransition()
            childViewController.didMove(toParent: nil)
            complete?()
        }
        
        if animation.isAnimated {
            childViewController.view.animate(out: animation, completion: localCompletion)
        } else {
            localCompletion(false)
        }
        
    }
}
