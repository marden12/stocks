//
//  SearchTableViewController.swift
//  AIFC project
//
//  Created by Dayana Marden on 20.07.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography
class SearchViewController: UIViewController {
    
    var results = [String]() {
        didSet{
         self.searchResultTableView.reloadData()
        }
    }
    var resultsOfCompanies = [String]() {
        didSet{
            self.searchResultTableView.reloadData()
        }
    }
    fileprivate lazy var navBar: UINavigationBar = {
        var navBar = UINavigationBar()
        navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        
        return navBar
    }()
    fileprivate lazy var  containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundColor
        view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width/2)
        return view
    }()
    fileprivate lazy var searchResultTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    fileprivate lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        button.addTarget(self, action: #selector(closeAction(_:)), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var searchInputTextField: UITextField = {
        let textField = UITextField()
        let paddingView = UIView(frame: CGRect(x:0,y: 0,width: 15, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextFieldViewMode.always
        textField.backgroundColor = UIColor.white
        textField.placeholder = "Search"
        textField.addTarget(self, action: #selector(textChanged(sender:)), for: .editingChanged)
        textField.becomeFirstResponder()
        textField.tintColor = .black
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.backgroundColor.cgColor
        textField.layer.cornerRadius = 5
        textField.leftViewMode = .always
        
        let emailImgContainer = UIView(frame: CGRect(x:textField.frame.origin.x + 5, y:textField.frame.origin.y, width:30.0, height:30.0))
        let emailImView = UIImageView(frame: CGRect(x:0,y: 0,width: 15.0,height: 16.0))
        emailImView.image = UIImage(named: "searchPlaceholder")
        emailImView.center = emailImgContainer.center
        emailImgContainer.addSubview(emailImView)
        textField.leftView = emailImgContainer
        return textField
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
    func setupViews(){
        view.addSubview(navBar)
        view.addSubview(searchResultTableView)
        navBar.addSubview(searchInputTextField)
        view.addSubview(closeButton)
        

    }
    
    
    func setupConstraints(){
        constrain(view,searchResultTableView,searchInputTextField,navBar){ v,tableView,textField,nav in
            nav.width == v.width
            nav.height == 70
            nav.centerX == v.centerX
            textField.height == nav.height/2
            textField.width == nav.width - 64
            textField.top == nav.top + 24
            tableView.width == v.width
            tableView.height == v.height
            tableView.top == nav.bottom + 8
        

        }
        constrain(navBar,closeButton,searchInputTextField){ nav,cb,textField in
            cb.width == 24
            cb.height == 24
            cb.left == nav.left + 16
            cb.top == nav.top + 26
            cb.right == textField.left - 8
            cb.centerY == textField.centerY
            
        }
    }

    func textChanged(sender: UITextField){
        resultsOfCompanies.removeAll()
        results.removeAll()
        StocksModel.searchCompany(sender.text!) { finalResuts in
            
            for i in finalResuts{
                
                self.results.append((i["des"])!)
                self.resultsOfCompanies.append((i["symbol"])!)
                print(self.results)
            }
        }
        
    }
    func closeAction(_: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTableViewCell
        let text = results[indexPath.row]
        let text2 = resultsOfCompanies[indexPath.row]
        cell.newsTitle.text = text2
        cell.postDate.text = text

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC =  CompanyViewController()
        self.present(nextVC, animated: true, completion: nil)
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath) as!SearchTableViewCell
        
        nextVC.nameOfCompany = currentCell.newsTitle.text!
  
    }


}

