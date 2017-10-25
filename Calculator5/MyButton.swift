//
//  MyButton.swift
//  Calculator5
//
//  Created by Victoriia Rohozhyna on 10/20/17.
//  Copyright © 2017 Victoriia Rohozhyna. All rights reserved.
//

import UIKit

extension UIButton {
    func flash () {
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.2
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 1
        
        layer.add(flash, forKey: nil)
    }
}
