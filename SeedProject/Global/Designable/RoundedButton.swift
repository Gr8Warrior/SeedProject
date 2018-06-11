//
//  RoundedButton.swift
//  SeedProject
//
//  Created by Shailendra Suriyal on 11/06/18.
//  Copyright © 2018 In Time Tec. All rights reserved.
//

import UIKit

import Foundation
import UIKit

@IBDesignable class RoundedButton: UIButton {
    
    @IBInspectable var gradientBottomColor: UIColor = UIColor.blue {
        didSet {
            setGradientBackground()
        }
    }
    
    @IBInspectable var gradientTopColor: UIColor = UIColor.white {
        didSet {
            setGradientBackground()
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var radius: CGFloat = 0 {
        didSet {
            updateCornerRadius()
        }
    }
    
    @IBInspectable var compactRadius: CGFloat = 0 {
        didSet {
            updateCornerRadius()
        }
    }
    
    @IBInspectable var localizationKey: String = ""
    
    let gradientLayer = CAGradientLayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setGradientBackground()
        updateCornerRadius()
    }
    
    func setGradientBackground() {
        gradientLayer.frame = bounds
        gradientLayer.colors = [gradientTopColor.cgColor, gradientBottomColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func updateCornerRadius() {
        let compact = traitCollection.verticalSizeClass == .compact
        layer.cornerRadius = compact ? compactRadius : radius
        gradientLayer.cornerRadius = compact ? compactRadius : radius
    }
    
}

