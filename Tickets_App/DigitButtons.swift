//
//  DigitButtons.swift
//  Assignment 1
//
//  Created by Roman Kantor on 2020-10-13.
//  Copyright © 2020 Roman Kantor. All rights reserved.
//

import UIKit

// Styling for all the buttons
class DigitButtons: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        setup()
    }
    
    private func setup(){
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 8.0
    }

}
