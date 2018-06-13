//
//  ConfigurableTextField.swift
//  Roam
//
//  Created by Alex Cole on 7/27/17.
//  Copyright © 2017 HP Inc. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class RoundedTextField: UITextField {
  
  @IBInspectable var padding: CGFloat = 20 {
    didSet {
      paddingRect = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
    }
  }
  
  @IBInspectable var height: CGFloat = 30 {
    didSet {
      var frameRect = frame
      frameRect.size.height = height
      frame = frameRect
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
  
  var paddingRect = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
  
  override func layoutSubviews() {
    super.layoutSubviews()
    updateCornerRadius()
  }
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return UIEdgeInsetsInsetRect(bounds, paddingRect)
  }
  
  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return UIEdgeInsetsInsetRect(bounds, paddingRect)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return UIEdgeInsetsInsetRect(bounds, paddingRect)
  }
  
  func updateCornerRadius() {
    let compact = traitCollection.verticalSizeClass == .compact
    layer.cornerRadius = compact ? compactRadius : radius
  }
  
}
