//
//  CustomButton.swift
//  JNKAltimeterDemo
//
//  Created by JosephNK on 2017. 4. 27..
//  Copyright © 2017년 JosephNK. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    var borderColor: UIColor? {
        didSet {
            self.layer.borderColor = borderColor?.cgColor
            //let _isEnabled = self.isEnabled
            //self.isEnabled = _isEnabled
        }
    }
    
    var borderHighlightedColor: UIColor? {
        didSet {
            //let _isEnabled = self.isEnabled
            //self.isEnabled = _isEnabled
        }
    }
    
    var borderDisabledColor: UIColor? {
        didSet {
            //let _isEnabled = self.isEnabled
            //self.isEnabled = _isEnabled
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            let layerBorderColor = self.layer.borderColor
            
            if isEnabled {
                if layerBorderColor != nil {
                    self.layer.borderColor = borderColor?.cgColor
                }
            }else {
                if layerBorderColor != nil {
                    self.layer.borderColor = borderDisabledColor?.cgColor
                }
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            let layerBorderColor = self.layer.borderColor
            
            if isHighlighted {
                if layerBorderColor != nil {
                    self.layer.borderColor = borderHighlightedColor?.cgColor
                }
            }else {
                if layerBorderColor != nil {
                    self.layer.borderColor = borderColor?.cgColor
                }
            }
        }
    }

}
