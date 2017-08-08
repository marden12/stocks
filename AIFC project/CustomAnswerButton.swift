//
//  CustomAnswerButton.swift
//  AIFC project
//
//  Created by Dayana Marden on 27.07.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography

class CustomAnswerButton: UIButton {

    let screen = UIScreen()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .backgroundColor
        self.layer.cornerRadius = 10
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
