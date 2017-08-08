//
//  LineGraphView.swift
//  AIFC project
//
//  Created by Dayana Marden on 08.08.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Alamofire

class LineGraphView: UIView {
    
    var linePath = UIBezierPath()
    var verticalPath = UIBezierPath()
    
    var maxY: CGFloat = 0
    var minY: CGFloat = 0
    
    
    public var lineWidth: CGFloat! = 0
    public var lineColor: UIColor!
    
    var data: [CGFloat]!
    var dates: [CGFloat: String]!
    
    var isToday = true
    var isFull = true
    var isLongPress = false
    
    var touchPosition: CGFloat!
    var previousLayer:CALayer!
    
    var longPressGesture: UILongPressGestureRecognizer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //custom logic goes here
    }
    
    func load(){
        if isFull {
            longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
            self.addGestureRecognizer(longPressGesture)
        }
    }
    
    
    func handleLongPress(sender: UILongPressGestureRecognizer){
        
        
        switch sender.state {
        case .changed:
            
            let location = sender.location(in: self).x
            let xInc = self.frame.width / CGFloat(data.count)
            let index = Int(abs(location / xInc ))
            
            print(data[index])
            
            
            
            let startPoint = CGPoint(x: CGFloat(index) * xInc, y: -20)
            let endPoint = CGPoint(x: CGFloat(index) * xInc, y: self.frame.height + 20)
            
            drawLineFromPoint(start: startPoint, toPoint: endPoint, ofColor: UIColor(hex:"BDBDBD"), inView: self)
            
        case .ended:
            isLongPress = false
        default:
            break
        }
        
    }
    
    func drawLineFromPoint(start : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor, inView view:UIView) {
        
        //design the path
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        let  dashes: [ CGFloat ] = [ 16.0, 32.0 ]
        path.setLineDash(dashes, count: dashes.count, phase: 0.0)
        path.lineCapStyle = .butt
        
        
        if self.previousLayer != nil {
            self.previousLayer.removeFromSuperlayer()
        }
        
        let shapeLayer = CAShapeLayer()
        
        self.previousLayer = shapeLayer
        
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = 2.0
        
        view.layer.addSublayer(shapeLayer)
    }
    
    override func draw(_ rect: CGRect) {
        
        if let points = self.data {
            
            let xInc = self.frame.width / CGFloat(points.count)
            let yInc = self.frame.height / (points.max()! - points.min()!)
            
            lineColor?.setFill()
            lineColor?.setStroke()
            
            
            
            self.linePath.move(to: CGPoint(x: 0, y: self.frame.height - (((points[0]) - points.min()! ) * yInc )))
            
            for (index,snap) in points.enumerated() {
                
                if index > 0 {
                    
                    let point: CGPoint = CGPoint(x: CGFloat(index) * xInc, y: self.frame.height - ((snap - points.min()!) * yInc))
                    self.linePath.addLine(to: point)
                }
                
            }
            
            self.linePath.lineWidth = self.lineWidth
            self.linePath.stroke()
            
        }
        
    }
    
    
    func showStocksFor(_ range: TimeRangeEnum, symbol: String){
        
        linePath.removeAllPoints()
        self.data = nil
        self.setNeedsDisplay()
        
        
        StocksModel.stocksFor(range, symbol: symbol) { (points, dates) in
            self.data = points
            self.dates = dates
            
            self.setNeedsDisplay()
        }
        
    }
    
    func updateGraphFor(data: [CGFloat]){
        
        
        linePath.removeAllPoints()
        self.data = nil
        self.setNeedsDisplay()
        
        self.data = data
        self.setNeedsDisplay()
    }
    
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
