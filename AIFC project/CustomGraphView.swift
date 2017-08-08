//
//  CustomCashView.swift
//  AIFC project
//
//  Created by Dayana Marden on 12.07.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import ScrollableGraphView
import Cartography

class CustomGraphView: UIView{
    let dateArray = ["1m","3m","6m","1y","2y"]
    lazy var labels: [String] = []
    var data: [Double] = [] {
        didSet{
            graphView.set(data: self.data, withLabels: [String(describing: self.data)])
            graphView.reloadInputViews()
        }
    }
    var last = Double()
    fileprivate lazy var graphView: ScrollableGraphView = {
        let graphView = ScrollableGraphView()
        graphView.referenceLineColor = .clear
        graphView.shouldShowLabels = false
        graphView.shouldShowReferenceLineUnits = false
        graphView.set(data: self.data, withLabels: [String(describing: self.data)])
        graphView.rangeMax = 931
        graphView.rangeMin = 927
        graphView.backgroundFillColor = .backgroundColor
        graphView.fillColor = .clear
        graphView.lineWidth = 2
        graphView.lineColor = UIColor.white
        graphView.lineStyle = ScrollableGraphViewLineStyle.smooth
//        graphView.adaptAnimationType = ScrollableGraphViewAnimationType.
//        graphView.animationDuration = 0.00007
        graphView.shouldFill = true
        graphView.dataPointSpacing = 3
        graphView.dataPointFillColor = UIColor.clear
        graphView.referenceLineLabelColor = .clear
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

