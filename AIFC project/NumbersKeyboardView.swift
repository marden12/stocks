//
//  NumbersKeyboardView.swift
//  stocks
//
//  Created by Robert Kim on 4/20/17.
//  Copyright © 2017 Octopus. All rights reserved.
//

import UIKit

protocol NumbersKeyboardDelegate: class {
    func keyWasTapped(character: String)
    func deleteKey()
}

class NumbersKeyboardView: UIView {
    
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    weak var delegate: NumbersKeyboardDelegate?


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let view = Bundle.main.loadNibNamed("NumbersKeyboard", owner: self, options: nil)?[0] as! UIView
        self.addSubview(view)
        self.backgroundColor = UIColor.clear
        view.frame = self.bounds
    }
    
    // MARK:- Button actions from .xib file
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        if sender == deleteButton {
            self.delegate?.deleteKey()
        } else {
            self.delegate?.keyWasTapped(character: sender.titleLabel!.text!)
        }
        
    }
    
}
