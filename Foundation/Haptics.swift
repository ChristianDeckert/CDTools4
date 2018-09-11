import UIKit
import Foundation
import AudioToolbox

public struct Haptics {
  
  public static func softTap() {
    if #available(iOS 10.0, *) {
      let generator = UISelectionFeedbackGenerator()
      generator.prepare()
      generator.selectionChanged()
    }
  }
  
  public static func doubleTap() {
    if #available(iOS 10.0, *) {
      let generator = UINotificationFeedbackGenerator()
      generator.prepare()
      generator.notificationOccurred(.warning)
    }
  }
  
  // a single tap via taptic engine
  public static func singleTap() {
    if #available(iOS 10.0, *) {
      let generator = UIImpactFeedbackGenerator(style: .heavy)
      generator.prepare()
      generator.impactOccurred()
    }
  }
  
  public static func vibrate() {
    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
  }
}


