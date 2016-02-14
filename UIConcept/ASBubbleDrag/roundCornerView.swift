//
//  roundCornerView.swift
//
//
//  Created by Alberto Scampini on 18/01/2016.
//  Copyright © 2016 Alberto Scampini. All rights reserved.
//

import UIKit

@IBDesignable
class roundCornerView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.CGColor
        }
    }
    
}
