//
//  UIView.swift
//  CapitalSocial
//
//  Created by Miguel angel olmedo perez on 11/5/18.
//  Copyright © 2018 Miguel angel olmedo perez. All rights reserved.
//

import UIKit

extension UIView {
    
    func applyShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.2
    }

    func coloredBorder(width: CGFloat = 2.0, color: UIColor = CSColor.primaryColor)  {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    func roundCorners(radius: CGFloat = 10) {
        self.layer.cornerRadius = radius
    }
    
    func applyCardStyle(radius: CGFloat = 10) {
        applyShadow()
        roundCorners(radius: radius)
    }
    
    /// Adds a vertical gradient color effect
    ///
    /// - Parameters:
    ///     - fromColor: Initial color
    ///     - toColor: Final color
    ///     - percentage: Percentage of the view that will be covered by the gradient (from 0 to 1)
    public func addGradient(fromColor: UIColor, toColor: UIColor, forViewPercentage percentage: CGFloat = 1) {
        let rect = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height * percentage)
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ fromColor.cgColor, toColor.cgColor]
        gradientLayer.locations = [ 0.0, 1.0]
        gradientLayer.frame = rect
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    ///Applies the gradient blue color to the specified view
    func applyGradientIntro() {
        self.addGradient(fromColor: UIColor(red: 0, green: 0, blue: 200/255.0, alpha: 1.0),
                         toColor: UIColor(red: 0, green: 0, blue: 255/255.0, alpha: 1.0))
    }
   
    
}
