//
//  CustomCashView.swift
//  AIFC project
//
//  Created by Dayana Marden on 12.07.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography

class CustomCashView: UIView {
    fileprivate lazy var cashLabel: UILabel = {
        let label = UILabel()
        label.text = "$1206.08"
        label.font = UIFont(name: Standart.regularFont.rawValue, size: 48)
        label.textColor = .white
        return label
    }()
    fileprivate lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "+$83(16%)"
        label.font = UIFont(name: Standart.regularFont.rawValue, size: 24)
        label.textColor = .white
        return label
    }()
    fileprivate lazy var incomeLabel: UILabel = {
        let label = UILabel()
        label.text = "today"
        label.font = UIFont(name: Standart.regularFont.rawValue, size: 24)
        label.textColor = .white
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        self.addSubview(cashLabel)
        self.addSubview(incomeLabel)
        self.addSubview(dateLabel)
    }
    
    func setupConstraints(){
        constrain(self,cashLabel,incomeLabel,dateLabel){s,cash,date,income in
        
            cash.top == s.top
            cash.left == s.left + 16
            date.top == cash.bottom
            date.left == s.left + 16
            income.centerY == cash.centerY
            income.right == s.right - 16
            income.left == cash.right
        }
    }
}

