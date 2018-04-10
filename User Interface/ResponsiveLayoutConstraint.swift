import Foundation
import UIKit

public class ResponsiveLayoutConstraint: NSLayoutConstraint {
    
    struct UserOverrides {
        var _3´5 = false, _4´0 = false, _4´7 = false, _5´5 = false, _5´8 = false, _7´9 = false, _9´7 = false, _10´5 = false, _12´9 = false
    }
}

public class ResponsiveConstantConstraint: ResponsiveLayoutConstraint {
    
    var didSetConst = UserOverrides()
    
    @IBInspectable public var _3´5Const: CGFloat = 0.0 { didSet {didSetConst._3´5 = true } }
    @IBInspectable public var _4´0Const: CGFloat = 0.0 { didSet {didSetConst._4´0 = true } }
    @IBInspectable public var _4´7Const: CGFloat = 0.0 { didSet {didSetConst._4´7 = true } }
    @IBInspectable public var _5´5Const: CGFloat = 0.0 { didSet {didSetConst._5´5 = true } }
    @IBInspectable public var _5´8Const: CGFloat = 0.0 { didSet {didSetConst._5´8 = true } }
    
    @IBInspectable public var _7´9Const: CGFloat = 0.0 { didSet {didSetConst._7´9 = true } }
    @IBInspectable public var _9´7Const: CGFloat = 0.0 { didSet {didSetConst._9´7 = true } }
    @IBInspectable public var _10´5Const: CGFloat = 0.0 { didSet {didSetConst._10´5 = true } }
    @IBInspectable public var _12´9Const: CGFloat = 0.0 { didSet {didSetConst._12´9 = true } }
    
    override public var constant: CGFloat {
        set {
            super.constant = newValue
        }
        get {
            switch UIScreen.size {
            case .threePointFiveInch:
                return didSetConst._3´5 ? self._3´5Const : super.constant
            case .fourInch:
                return didSetConst._4´0 ? self._4´0Const : super.constant
            case .fourPointSevenInch:
                return didSetConst._4´7 ?  self._4´7Const : super.constant
            case .fivePointFiveInch:
                return didSetConst._5´5 ? self._5´5Const : super.constant
            case .fivePointEightInch:
                return didSetConst._5´8 ? self._5´8Const : super.constant
            case .sevenPointNine:
                return didSetConst._7´9 ? self._7´9Const : super.constant
            case .ninePointSeven:
                return didSetConst._9´7 ? self._9´7Const : super.constant
            case .tenPointFive:
                return didSetConst._10´5 ? self._10´5Const : super.constant
            case .twelvePointNine:
                return didSetConst._12´9 ? self._12´9Const : super.constant
            case .unknown:
                return super.constant
            }
        }
    }
}

public extension UIScreen {
    
    public enum Size {
        case unknown
        case threePointFiveInch
        case fourInch
        case fourPointSevenInch
        case fivePointFiveInch
        case fivePointEightInch
        
        case sevenPointNine
        case ninePointSeven
        case tenPointFive
        case twelvePointNine
    }
    
    class var width:CGFloat { return UIScreen.main.bounds.size.width }
    class var height:CGFloat { return UIScreen.main.bounds.size.height }
    class var maxLength:CGFloat { return max(width, height) }
    class var minLength:CGFloat { return min(width, height) }
    
    class var isZoomed:Bool { return UIScreen.main.nativeScale >= UIScreen.main.scale }
    class var isRetina:Bool { return UIScreen.main.scale >= 2.0 }
    class var isPhone:Bool { return UIDevice.current.userInterfaceIdiom == .phone }
    class var isPad:Bool { return UIDevice.current.userInterfaceIdiom == .pad }
    class var isCarplay:Bool { return UIDevice.current.userInterfaceIdiom == .carPlay }
    class var isTv:Bool { return UIDevice.current.userInterfaceIdiom == .tv }
    
    public class var size: UIScreen.Size {
        if isPhone && maxLength < 568 {
            return .threePointFiveInch
        } else if isPhone && maxLength == 568 {
            return .fourInch
        } else if isPhone && maxLength == 667 {
            return .fourPointSevenInch
        } else if isPhone && maxLength == 736 {
            return .fivePointFiveInch
        } else if isPhone && maxLength == 812 {
            return .fivePointEightInch
        } else if isPad && maxLength == 1024 {
            return .ninePointSeven
        } else if isPad && maxLength == 1112 {
            return .tenPointFive
        } else if isPad && maxLength == 1366 {
            return .twelvePointNine
        }
        return .unknown
    }
}
