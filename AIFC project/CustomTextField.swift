//
//  CustomTextField.swift
//  AIFC project
//
//  Created by Dayana Marden on 19.07.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography
import SkyFloatingLabelTextField
class CustomTextField: SkyFloatingLabelTextField{

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: 200, height: 45)
        self.titleColor = .white
        self.tintColor = .white
        self.titleFont = UIFont(name: Standart.font.rawValue, size: 8)!
        self.textColor = .white
        self.font = UIFont(name: Standart.font.rawValue, size: 16)
        self.textAlignment = .left
        self.lineHeight = 1
        self.lineColor = .white
        self.selectedLineColor = .white
        self.tintColorDidChange()
        self.selectedLineHeight = 1
        self.autocapitalizationType = .none
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
    }
    func setupConstraints(){
        
    }

}
