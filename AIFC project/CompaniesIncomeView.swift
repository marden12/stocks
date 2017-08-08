//
//  CompaniesIncomeView.swift
//  AIFC project
//
//  Created by Dayana Marden on 13.07.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography

enum Standart: String {
    
    case font = "OpenSans-Light"
}



class CompaniesIncomeView: UIView {
    var text:String = ""
    fileprivate lazy var todayCost: UILabel = {
        let label = UILabel()
        label.text = self.text
        label.font = UIFont(name: Standart.font.rawValue, size: 56)
        label.textColor = .white
        return label
    }()
    fileprivate lazy var todayIncome: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "+0.16(0.61%)today"
        label.font = UIFont(name: Standart.font.rawValue, size: 18)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        self.addSubview(todayCost)
        self.addSubview(todayIncome)
    }
    func setupConstraints(){
        constrain(self,todayCost,todayIncome){ s,cost,income in
            cost.centerX == s.centerX
            cost.top == s.top
            income.top == cost.bottom
            income.centerX == s.centerX
    }

    }
}
