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
    let dateArray = ["1m","1m"]
    lazy var labels: [String] = []
    var data: [Double] = [] {
        didSet{
            graphView.set(data: self.data, withLabels: self.dateArray)
            graphView.reloadInputViews()
        }
    }
    var minRange:Double = 0.0 {
        didSet{
            graphView.rangeMin = self.minRange
            graphView.reloadInputViews()
        }
    }
    var maxRange:Double = 0.0 {
        didSet{
            graphView.rangeMax = self.maxRange
            graphView.reloadInputViews()
        }
    }

    var last = Double()
    fileprivate lazy var graphView: ScrollableGraphView = {
        let graphView = ScrollableGraphView()
        graphView.rangeMax = self.minRange
        graphView.rangeMin = self.maxRange
        graphView.set(data: self.data, withLabels: self.labels)
        graphView.referenceLineColor = .white
        graphView.shouldShowLabels = false
        graphView.shouldShowReferenceLineUnits = false
        graphView.backgroundFillColor = .backgroundColor
        graphView.fillColor = .clear
        graphView.lineWidth = 2
        graphView.lineColor = UIColor.white
        graphView.shouldAnimateOnStartup = false
        graphView.lineStyle = ScrollableGraphViewLineStyle.smooth
        graphView.dataPointSpacing = 3
        graphView.dataPointFillColor = UIColor.clear
        graphView.referenceLineLabelColor = .white
        graphView.leftmostPointPadding = 50
        return graphView
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

