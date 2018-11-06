//
//  CSLoader.swift
//  CapitalSocial
//
//  Created by Miguel angel olmedo perez on 11/5/18.
//  Copyright © 2018 Miguel angel olmedo perez. All rights reserved.
//

import Foundation
import UIKit

// A delay function
func delay(_ seconds: Double, completion: @escaping ()->Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}


final class LoaderCircleAnimation {
    
    
    /// Set animation on layer give a location over layer and size.
    ///
    /// How to use:
    ///
    ///         let animation = LoaderCircleAnimation()
    ///         animation.setUpAnimation(in: view.layer, location: CGPoint(x: 100, y: 100), size: CGSize(width: 50, height: 50), color: UIColor.red)
    
    /// - Parameters:
    ///   - layer: The container layer
    ///   - location: location over layer
    ///   - size: loader`s size
    ///   - color: color of loader
    class public func setUpAnimation(in layer: CALayer, location: CGPoint,  size: CGSize, color: UIColor) {
        
        let beginTime: Double = 0.35
        let strokeStartDuration: Double = 1.2
        let strokeEndDuration: Double = 0.7
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.byValue = Float.pi * 2
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.duration = strokeEndDuration
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = 1
        strokeEndAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.duration = strokeStartDuration
        strokeStartAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
        strokeStartAnimation.fromValue = 0
        strokeStartAnimation.toValue = 1
        strokeStartAnimation.beginTime = beginTime
        strokeStartAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [rotationAnimation, strokeEndAnimation, strokeStartAnimation]
        groupAnimation.duration = strokeStartDuration + beginTime
        groupAnimation.repeatCount = .infinity
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.fillMode = .forwards
        
        let circle = layerWith(size: size, color: color, width: 3)
        let frame = CGRect(
            x: location.x,
            y: location.y,
            width: size.width,
            height: size.height
        )
        
        circle.frame = frame
        circle.add(groupAnimation, forKey: "animation")
        let backgroundCircle = layerWith(size: size, color: UIColor.black, width: 0.5)
        backgroundCircle.frame = frame
        layer.addSublayer(backgroundCircle)
        layer.addSublayer(circle)
    }
    
    class private func layerWith(size: CGSize, color: UIColor, width: CGFloat) -> CALayer {
        let layer: CAShapeLayer = CAShapeLayer()
        let path: UIBezierPath = UIBezierPath()
        
        path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                    radius: size.width / 2,
                    startAngle: -(.pi / 2),
                    endAngle: .pi + .pi / 2,
                    clockwise: true)
        layer.fillColor = nil
        layer.strokeColor = color.cgColor
        layer.lineWidth = width
        
        layer.backgroundColor = nil
        layer.path = path.cgPath
        layer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        return layer
    }
}
