//
//  Utilities.swift
//  DogCare
//
//  Created by user167535 on 6/11/20.
//  Copyright © 2020 user167535. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static func styleTextField(_ textfield:UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 240/255, green: 205/255, blue: 121/255, alpha: 1).cgColor
        textfield.borderStyle = .none
        textfield.layer.addSublayer(bottomLine)
    }
    
    static func styleFilledButton(_ button:UIButton) {
        button.backgroundColor = UIColor.init(red: 240/255, green: 205/255, blue: 121/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button:UIButton) {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    
    
}

