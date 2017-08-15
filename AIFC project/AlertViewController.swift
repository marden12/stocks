//
//  AlertViewController.swift
//  AIFC project
//
//  Created by Dayana Marden on 14.08.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit

class AlertViewController: UIAlertController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Error"
        self.message = "Something wrong, please try again"
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        self.addAction(cancel)
        
        // Do any additional setup after loading the view.
    }



}
