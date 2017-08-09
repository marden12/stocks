//
//  TradeViewController.swift
//  AIFC project
//
//  Created by Dayana Marden on 28.07.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import FirebaseCore

class TradeViewController: UIViewController,NumbersKeyboardDelegate {
    var name = ""
    var buttonName = ""
    var items: [OwnStock] = []
    var ref = Database.database().reference(withPath: "companies_of_users")
    let usersRef = Database.database().reference(withPath: "online")
    var user: User!
    let keyboardView = NumbersKeyboardView(frame: CGRect(x: 0, y: 0, width: 0, height: UIScreen.main.bounds.height * 0.45))
    
    
    fileprivate lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.textAlignment = .right
        textField.font = UIFont(name: Standart.font.rawValue, size: 48)
        textField.textColor = .backgroundColor
        textField.tintColor = .backgroundColor
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChanged(textField:)), for: .editingChanged)
        textField.placeholder = "0"
        textField.addTarget(self, action: #selector(deleteKey), for: .allEvents)
        textField.addTarget(self, action: #selector(keyWasTapped(character:)), for: .allEvents)
        return textField
    }()
    fileprivate lazy var numberOfShares: UILabel = {
        let label = UILabel()
        label.text = "number of shares"
        label.textColor = UIColor.lightgray2
        label.font = UIFont(name: Standart.font.rawValue, size: 18)
        return label
    }()
    fileprivate lazy var marketPriceLAbel: UILabel = {
        let label = UILabel()
        label.text = "market price"
        label.textColor = UIColor.lightgray2
        label.font = UIFont(name: Standart.font.rawValue, size: 18)
        return label
    }()
    fileprivate lazy var totalCostLabel: UILabel = {
        let label = UILabel()
        label.text = "total cost"
        label.textColor = UIColor.lightgray2
        label.font = UIFont(name: Standart.font.rawValue, size: 18)
        return label
    }()
    fileprivate lazy var costOnTrade: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Standart.font.rawValue, size: 24)
        return label
    }()
    
    fileprivate lazy var totalCost: UILabel = {
        let label = UILabel()
        label.text = "$0"
        label.font = UIFont(name: Standart.font.rawValue, size: 24)
        return label
    }()
    fileprivate lazy var buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Buy", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .backgroundColor
        button.addTarget(self, action: #selector(buyAction), for: .touchUpInside)
        return button
    }()
    var marketPrice: Double! {
        didSet{
            costOnTrade.text = "$\(marketPrice!)"
        }
    }
    fileprivate lazy var navBar: UINavigationBar = {
        var navBar = UINavigationBar()
        navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        navBar.barTintColor = .white
        return navBar
    }()
    fileprivate lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back-green"), for: .normal)
        button.addTarget(self, action: #selector(closeAction(_:)), for: .touchUpInside)
        return button
    }()
    fileprivate lazy var nameOfCompany: UILabel = {
        let label = UILabel()
        label.textColor = .backgroundColor
        label.font = UIFont(name: Standart.font.rawValue, size: 18)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardView.delegate = self
        keyboardView.becomeFirstResponder()
        deleteKey()
        navigationController?.navigationBar.barTintColor = .white
        marketPrice = 12.0
        print(items)
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        nameOfCompany.text = name
    }
    override func viewDidAppear(_ animated: Bool) {
        inputTextField.becomeFirstResponder()
        keyboardView.becomeFirstResponder()
    }
    func setupViews(){
        view.addSubview(inputTextField)
        view.addSubview(numberOfShares)
        view.addSubview(costOnTrade)
        view.addSubview(totalCost)
        view.addSubview(marketPriceLAbel)
        view.addSubview(totalCostLabel)
        view.addSubview(buyButton)
        view.addSubview(navBar)
        navBar.addSubview(closeButton)
        navBar.addSubview(nameOfCompany)
    }
    
    func setupConstraints(){
        constrain(inputTextField,view,numberOfShares,costOnTrade,totalCost) {textField, v, shares,trade,total in
            textField.width == v.width/2
            textField.height == 45
            textField.right == v.right - 16
            textField.top == v.top + 60
            
            shares.left == v.left + 16
            shares.centerY == textField.centerY
            
            trade.top == textField.bottom + 8
            trade.right == v.right - 16
            
            total.top == trade.bottom + 8
            total.right == v.right - 16
        }
        constrain(numberOfShares,marketPriceLAbel,view,costOnTrade){ n,m,v,c in
            m.top == n.bottom + 16
            m.centerY == c.centerY
            m.left == v.left + 16
        }
        constrain(marketPriceLAbel,totalCostLabel,totalCost,view,buyButton){ m,tl,t,v,button in
            tl.top == m.bottom + 8
            tl.left == v.left + 16
            tl.centerY == t.centerY
            button.width == v.width - 16
            button.height == 45
            button.centerX == v.centerX
            button.top == t.bottom + 16
        }
        constrain(closeButton,navBar,nameOfCompany) { cb,nav,label in
            cb.left == nav.left + 16
            cb.top == nav.bottom - 32
            label.centerY == cb.centerY
            label.centerX == nav.centerX
        }
        
        
    }
    func textFieldDidChanged(textField: UITextField){
        if let text = textField.text as NSString? {
            let amount = text.doubleValue
            totalCost.text = "$\(amount * marketPrice)"
        }
    }
    func keyWasTapped(character: String) {
        print("vlvlvl")
        inputTextField.insertText(character)
        print("YEEES\(character)")
    }

    
    func deleteKey(){
        inputTextField.deleteBackward()
    }
    
    func closeAction(_: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    func buyAction(){
        let companiesItems = nameOfCompany.text
        let comItemRef = self.ref.child(Auth.auth().currentUser!.uid + "/" + companiesItems!)
        let otherItems = OwnStock(name: nameOfCompany.text! , price: totalCost.text!, stocks: inputTextField.text!)
        comItemRef.setValue(otherItems.toAnyObject())
        items.append(otherItems)
        self.dismiss(animated: true, completion: nil)
        
        
    }

}

extension TradeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = inputTextField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 5
    }
    
  
}
