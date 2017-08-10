//
//  OwnStocksTableViewCell.swift
//  AIFC project
//
//  Created by Dayana Marden on 09.07.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography
import ScrollableGraphView

class OwnStocksTableViewCell: UITableViewCell {
    lazy var data: [Double] = []
    lazy var maxRange = Double()
    lazy var minRange = Double()
    public lazy var companyNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "GOOG"
        label.font = UIFont(name: Standart.font.rawValue, size: 24)
        return label
    }()
    public lazy var tinyGraphView: CustomGraphView = {
        let graphView = CustomGraphView()
        graphView.data = self.data
        graphView.maxRange = self.maxRange
        graphView.minRange = self.minRange
        return graphView

    }()
    public lazy var stockCount: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.text = "Stock:7"
        label.font = UIFont(name: Standart.font.rawValue, size: 16)
        return label
    }()
    public lazy var revenueView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        return view
    }()
    public lazy var сompanyRevenue: UILabel = {
        let label = UILabel()
        label.text = "$100"
        label.textColor = .backgroundColor
        label.font = UIFont(name: Standart.font.rawValue, size: 24)
        return label
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(companyNameLabel)
        self.addSubview(stockCount)
        self.addSubview(tinyGraphView)
        revenueView.addSubview(сompanyRevenue)
        self.addSubview(revenueView)
        setupConstrains()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented coder")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupConstrains(){
        constrain(self,companyNameLabel,stockCount,tinyGraphView,revenueView){ s,label,stock,gV,cR in
            label.left == s.left + 10
            label.centerY == s.centerY
            stock.top == label.bottom
            stock.left == s.left + 10
            gV.centerX == s.centerX
            gV.height == s.height
            gV.width == s.width/4
            cR.width == s.width/4
            cR.height == 50
            cR.right == s.right - 10
            cR.centerY == s.centerY
           
            
        }
        constrain(revenueView,сompanyRevenue){ v,label in
            label.center == v.center
        }
    }
    

}
