//
//  GrathCheckViewController.swift
//  AIFC project
//
//  Created by Dayana Marden on 23.08.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography
import ScrollableGraphView
class GrathCheckViewController: UIViewController {
    let arr = [10.0,2.0,10.0,15.0,3.0,4.0,6.0,12.0,2.0]
    let labels = ["","",""]
    fileprivate lazy var graph: ScrollableGraphView = {
        let graph = ScrollableGraphView()
        graph.rangeMax = self.arr.max()!
        graph.rangeMin = self.arr.min()!
        graph.set(data: self.arr, withLabels: self.labels)
        return graph
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(graph)
        constrain(graph,view){g,v in
            g.width == v.width
            g.height == v.height/2
            g.center == v.center
        }
    }


}
