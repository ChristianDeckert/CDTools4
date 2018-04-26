import Foundation
import UIKit

/**
 A subclass of `UITextView` that grows with its text without completely disabling scrolling. It does this by updating
 `intrinsicContentSize`. This means you can set inequality constraints so the text is only scrollable under certain
 conditions. (e.g. you can set a maximum with a ≤ constraint).
 - Note:
 See [this gist](https://gist.github.com/Bogidon/632e265b784ef978d5d8c0b86858c2ee) for an alternate version that can animate.
 */
@IBDesignable
public class GrowingTextView: UITextView {
    
    /// Determines whether there is an animation when the intrisic size changes to match the content size. Defaults to `true`.
    public var isGrowingAnimated = true
    
    /// The duration for growing the intrinsic size to the content size. Defaults to `0.2`.
    public var growingAnimationDuration: TimeInterval = 0.2
    
    private var didStartChangingText = false
    private lazy var oldText: String = self.textStorage.string
    
    public override var contentSize: CGSize {
        didSet {
            if didStartChangingText {
                invalidateIntrinsicContentSize(animated: isGrowingAnimated)
            } else {
                // textStorage is empty the first time it's set
                let isTextStorageEmpty = oldText.isEmpty
                let isTextStorageSame = oldText == textStorage.string
                didStartChangingText = !(isTextStorageEmpty || isTextStorageSame)
                oldText = textStorage.string
                
                if didStartChangingText {
                    invalidateIntrinsicContentSize(animated: isGrowingAnimated)
                } else {
                    invalidateIntrinsicContentSize(animated: false)
                }
            }
        }
    }
    
    /// Adds ability to animate `invalidateIntrinsicContentSize`
    private func invalidateIntrinsicContentSize(animated: Bool) {
        if animated {
            UIView.animate(withDuration: growingAnimationDuration) {
                self.invalidateIntrinsicContentSize()
                self.setNeedsLayout()
                self.layoutIfNeeded()
            }
        } else {
            invalidateIntrinsicContentSize()
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        let width = super.intrinsicContentSize.width
        return CGSize(width: width, height: contentSize.height)
    }
}

