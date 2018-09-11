import UIKit
import Foundation
import AudioToolbox

public struct Haptics {
    
    public static func softTap(fallbackVibration: Bool = false) {
        if #available(iOS 10.0, *) {
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
        } else if fallbackVibration {
            // Fallback on earlier versions
            vibrate()
        }
        
    }
    
    public static func doubleTap(type: UINotificationFeedbackGenerator.FeedbackType = .warning, fallbackVibration: Bool = false) {
        if #available(iOS 10.0, *) {
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(type)
        } else if fallbackVibration {
            // Fallback on earlier versions
            vibrate()
        }
        
    }
    
    // a single tap via taptic engine
    public static func singleTap(style: UIImpactFeedbackGenerator.FeedbackStyle = .heavy, fallbackVibration: Bool = false) {
        if #available(iOS 10.0, *) {
            let generator = UIImpactFeedbackGenerator(style: style)
            generator.prepare()
            generator.impactOccurred()
        } else if fallbackVibration {
            // Fallback on earlier versions
            vibrate()
        }
        
    }
    
    public static func vibrate() {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
}
