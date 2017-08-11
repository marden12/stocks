//
//  CustomCashView.swift
//  AIFC project
//
//  Created by Dayana Marden on 12.07.17.[
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import ScrollableGraphView
import Cartography

class CustomGraphView: UIView{
    let dateArray = ["1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m","1m"]
    lazy var labels: [String] = []
    var data: [Double] = [] {
        didSet{
            graphView.set(data: self.data, withLabels: [String(describing: self.data)])
            graphView.reloadInputViews()
        }
    }
    var minRange = Double() {
        didSet{
            graphView.rangeMin = self.minRange
            graphView.reloadInputViews()
        }
    }
    var maxRange = Double() {
        didSet{
            graphView.rangeMax = self.maxRange
            graphView.reloadInputViews()
        }
    }
    
    var minRange2 = Double() {
        didSet{
            graphView.rangeMin = self.minRange
            graphView.reloadInputViews()
        }
    }
    var maxRange2 = Double() {
        didSet{
            graphView.rangeMax = self.maxRange
            graphView.reloadInputViews()
        }
    }
    var last = Double()
    fileprivate lazy var graphView: ScrollableGraphView = {
        let graphView = ScrollableGraphView()
        graphView.referenceLineColor = .white
        graphView.shouldShowLabels = false
        graphView.shouldShowReferenceLineUnits = true

        graphView.set(data: self.data, withLabels: self.dateArray)
        graphView.rangeMax = self.maxRange
        graphView.rangeMin = self.minRange
        graphView.backgroundFillColor = .backgroundColor
        graphView.fillColor = .clear
        graphView.lineWidth = 2
        graphView.lineColor = UIColor.white
        graphView.lineStyle = ScrollableGraphViewLineStyle.smooth
        graphView.shouldAnimateOnStartup = false
        graphView.animationDuration = 0.07
        graphView.shouldFill = true
        graphView.dataPointSpacing = 3
        graphView.dataPointFillColor = UIColor.clear
        graphView.referenceLineLabelColor = .white
        graphView.shouldRangeAlwaysStartAtZero = true
        graphView.topMargin = 32

        return graphView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        let label = String()
        for i in 1...dateArray.count{
            labels.append(label)
            print(i)
        }
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        self.addSubview(graphView)
    }
    
    func setupConstraints(){
        constrain(graphView,self){ graphView,s in
            graphView.width == s.width
            graphView.height == s.height
            graphView.top == s.top + 16
            graphView.centerX == s.centerX

        }
    }
}

