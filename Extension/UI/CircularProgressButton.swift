//
//  CircularProgressButton.swift
//  flashcards
//
//  Created by Christian on 25.04.18.
//  Copyright © 2018 cda. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public class CircularProgressButton: AnimatedButton {
    
    public enum TimingFunction {
        
        case `default`
        case linear
        case easeIn
        case easeOut
        case easeInOut
        
        public func asCATimingFunction() -> String {
            switch self {
            case .linear: return kCAMediaTimingFunctionLinear
            case .easeIn: return kCAMediaTimingFunctionEaseIn
            case .easeOut: return kCAMediaTimingFunctionEaseOut
            case .easeInOut: return kCAMediaTimingFunctionEaseInEaseOut
            default: return kCAMediaTimingFunctionDefault
            }
        }
    }
    
    @IBInspectable public var lineWidth: CGFloat = 4.0
    
    public override var shouldAnimate: Bool {
        get {
            return false
        }
        set {
            super.shouldAnimate = false
        }
    }
    
    public var timingFunction: TimingFunction = .linear
    
    @IBInspectable public var strokeColor: UIColor = UIApplication.shared.keyWindow?.rootViewController?.view.tintColor ?? UIColor.blue {
        didSet {
            circleLayer.strokeColor = strokeColor.cgColor
        }
    }
    
    
    public lazy var lightCircleLayer: CAShapeLayer = {
        let circleLayer = CAShapeLayer()
        circleLayer.frame = bounds
        circleLayer.path = updatedPath().cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = strokeColor.withAlphaComponent(0.1).cgColor
        circleLayer.lineWidth = lineWidth;
        circleLayer.strokeEnd = 1.0
        
        layer.addSublayer(circleLayer)
        return circleLayer
    }()
    
    public lazy var circleLayer: CAShapeLayer = {
        let circleLayer = CAShapeLayer()
        circleLayer.frame = bounds
        circleLayer.path = updatedPath().cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = strokeColor.cgColor
        circleLayer.lineWidth = lineWidth;
        circleLayer.strokeEnd = 0.0
        
        layer.addSublayer(circleLayer)
        return circleLayer
    }()
    
    public var currentProgress: CGFloat {
        return circleLayer.strokeEnd
    }
    
    private func updatedPath() -> UIBezierPath {
        let center = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0)
        let radius = (frame.size.width - 2 * lineWidth)/2
        
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0.0, endAngle: CGFloat.pi * 2, clockwise: true)
        return circlePath
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupCircleLayer()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
//        setupCircleLayer()
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
//        guard circleLayer.path == nil else { return }
//        setupCircleLayer()
    }
    
    private func setupCircleLayer() {
        circleLayer.frame = bounds
        circleLayer.path = updatedPath().cgPath
        
        lightCircleLayer.path = updatedPath().cgPath
        layer.insertSublayer(lightCircleLayer, below: circleLayer)
        //        self.sendSubview(toBack: customImageView)
    }
    
    public func animate(to value: CGFloat = 1.0, from: CGFloat? = nil, duration: TimeInterval? = nil) {
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        // Set the animation duration appropriately
        animation.duration = duration ?? super.animationDuration
        
        // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = from ?? currentProgress
        animation.toValue = value
        
        // Do a linear animation (i.e The speed of the animation stays the same)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        circleLayer.strokeEnd = value
        circleLayer.add(animation, forKey: "animateCircle")
    }
}
