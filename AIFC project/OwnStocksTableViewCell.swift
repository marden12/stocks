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
    let dateArray = ["1m","1m"]
    lazy var labels: [String] = []
    var data: [Double] = [] {
        didSet{
            tinyGraphView.set(data: self.data, withLabels: [String(describing: self.data)])
            tinyGraphView.reloadInputViews()
        }
    }
    var minRange:Double = 0.0 {
        didSet{
            tinyGraphView.rangeMin = self.minRange
            tinyGraphView.reloadInputViews()
        }
    }
    var maxRange:Double = 0.0 {
        didSet{
            tinyGraphView.rangeMax = self.maxRange
            tinyGraphView.reloadInputViews()
        }
    }
    public lazy var companyNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "GOOG"
        label.font = UIFont(name: Standart.font.rawValue, size: 24)
        return label
    }()
    public lazy var tinyGraphView: ScrollableGraphView = {
        let graphView = ScrollableGraphView()
        graphView.referenceLineColor = .clear
        graphView.shouldShowLabels = false
        graphView.shouldShowReferenceLineUnits = false
        graphView.set(data: self.data, withLabels: self.dateArray)
        graphView.rangeMin = 908
        graphView.rangeMax = self.maxRange
        graphView.backgroundFillColor = .white
        graphView.fillColor = .clear
        graphView.lineWidth = 0.8
        graphView.lineColor = UIColor.backgroundColor
        graphView.lineStyle = ScrollableGraphViewLineStyle.smooth
        graphView.shouldAnimateOnStartup = false
        graphView.shouldAdaptRange = true
        graphView.shouldFill = true
        graphView.dataPointSpacing = 1
        graphView.referenceLineNumberOfDecimalPlaces = 2
        graphView.dataPointFillColor = UIColor.clear
        graphView.referenceLineLabelColor = .white
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
            gV.width == s.width/3
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
