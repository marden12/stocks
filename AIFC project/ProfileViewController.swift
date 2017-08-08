//
//  Profile2ViewController.swift
//  AIFC project
//
//  Created by Dayana Marden on 12.07.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography
import ScrollableGraphView
import FirebaseDatabase
import FirebaseAuth
class ProfileViewController: UIViewController {
    var selectedIndexPath: IndexPath?
    var array: [CDOwnStocks] = []
    var height = CGFloat()
    let authService = AuthenticationService()
    var items: [OwnStock] = []
    var arr = OwnStock(name: "", price: "", stocks: "")
    var dateArray = ["1D","1W","1M","3M","6M","1Y"]
    var name = ""
    var stocks = ""
    var price = ""
    var type = ""
    var pointsArray:[Double] = []
    
    var ref: DatabaseReference?
    var databaseHandle:DatabaseHandle?
    
    
    fileprivate lazy var  containerView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        return view
    }()
    fileprivate lazy var graphView: CustomGraphView = {
        let view = CustomGraphView()
        view.data = self.pointsArray
        return view
    }()
    fileprivate lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isUserInteractionEnabled = true
        collectionView.backgroundColor = .backgroundColor
        collectionView.register(DateCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    fileprivate lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width/6 ,height: 24)
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        return layout
    }()

    fileprivate lazy var cashView: CustomCashView = {
        let view = CustomCashView()
        view.isUserInteractionEnabled = true

        return view
    }()
    fileprivate lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "search"), for: .normal)
        button.addTarget(self, action: #selector(goToSearhViewController(_:)), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "menu"), for: .normal)
        button.addTarget(self, action: #selector(logOutAction(_:)), for: .touchUpInside)
        return button
    }()

    fileprivate lazy var listOfStocks: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = self.containerView
        tableView.rowHeight = 90
        tableView.register(OwnStocksTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    fileprivate lazy var openTableButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "down-arrow"), for: .normal)
        button.addTarget(self, action: #selector(openListOfStocks(_:)), for: .touchUpInside)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        fetchGraph(newType: "day")
        setupViews()
        setupConstraints()
        listOfStocks.reloadData()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        let item1 = UIBarButtonItem(customView: searchButton)
        self.navigationItem.setRightBarButton(item1, animated: true)
        let item2 = UIBarButtonItem(customView: menuButton)
        self.navigationItem.setLeftBarButton(item2, animated: true)
   
        
    }
    
    func setupViews(){
        containerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64)
        view.addSubview(listOfStocks)
        view.addSubview(searchButton)
        containerView.addSubview(cashView)
        containerView.addSubview(openTableButton)
        containerView.addSubview(collectionView)
        
    }
    
    func setupConstraints(){
        constrain(listOfStocks,view,searchButton,menuButton){ list,v,search,menu in
            list.left == v.left
            list.right == v.right
            list.bottom == v.bottom
            list.top == v.top 
            search.width == 24
            search.height == 24
            menu.width == 24
            menu.height == 24
        }
        constrain(containerView,cashView,openTableButton,view){container,cash, button, v in
            cash.top == container.bottom - 150
            cash.width == container.width
            cash.height == container.height/2 - 64
            cash.centerX == container.centerX
            button.centerX == container.centerX
            button.bottom == container.bottom - 10
            button.width == 24
            button.height == 24
        }
        constrain(collectionView,view,cashView){ collectionView,v,cashView in
            collectionView.bottom == cashView.top - 16
            collectionView.centerX == v.centerX
            collectionView.width == v.width
            collectionView.height == 64
        }
        
        
        
    }
    func constraintsToGraph(){
        constrain(collectionView,containerView,graphView){ collectionView,v,graphView in
            graphView.top == v.top + 8
            graphView.centerX == v.centerX
            graphView.width == v.width - 16
            graphView.height == v.height/2
        }
    }
    func constraintsToGraphWeek(){
        constrain(collectionView,containerView,graphView){ collectionView,v,graphView in
            graphView.top == v.top + 8
            graphView.centerX == v.centerX
            graphView.width == v.width - 16
            graphView.height == v.height/2
        }
    }
    func logOutAction(_:UIButton){
        authService.logout()
    }
    func openListOfStocks(_:UIButton){
        let indexPath = NSIndexPath(item: 0, section: 0)
        listOfStocks.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
    }
    func goToSearhViewController(_: UIButton){
        let nextViewController = SearchViewController()
        navigationController?.present(nextViewController, animated: true, completion: nil)
    }
    func fetchData(){
        ref = Database.database().reference()
        ref?.child("companies_of_users/" + ((Auth.auth().currentUser)?.uid)!).observe(.value, with: {(snapshot) in
            
            
            if let children = snapshot.children.allObjects as? [DataSnapshot] {
                self.items.removeAll()
                for child in children {
                    
                    if let childElement = child.value as? [String: Any] {
                        self.name = childElement["name"]! as! String
                        self.price = childElement["price"]! as! String
                        self.stocks = childElement["stocks"]! as! String
                        print(self.name)
                        self.arr = OwnStock(name: self.name, price: self.price, stocks: self.stocks)
                        self.items.append(self.arr)
                    }

                }
                
            } else {
                print("parse failure ")
            }
            
            DispatchQueue.main.async {
                self.listOfStocks.reloadData()
            }
            
        })
    }
    
    func fetchGraph(newType: String){
        StocksModel.getGraphPoints("GOOG", type: newType) { points in
            self.graphView.data = points
            print(self.graphView.data)
            self.containerView.addSubview(self.graphView)
            self.constraintsToGraph()
        }
    }
    func fetchGraphWeek(newType: String){
        StocksModel.getGraphPoints("GOOG", type: newType) { points in
            self.graphView.data = points
            print(self.graphView.data)
            self.containerView.addSubview(self.graphView)
            self.constraintsToGraph()
        }
    }
}
//MARK:: List of Stocks, Table View
extension ProfileViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OwnStocksTableViewCell
        cell.selectionStyle = .none
        cell.companyNameLabel.text = items[indexPath.row].name
        cell.stockCount.text = items[indexPath.row].stocks
        cell.сompanyRevenue.text = items[indexPath.row].price
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = CompanyViewController()
        self.present(nextViewController, animated: true, completion: nil)
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath) as! OwnStocksTableViewCell
        nextViewController.nameOfCompany = currentCell.companyNameLabel.text!
        nextViewController.costOfStock = currentCell.сompanyRevenue.text!
        nextViewController.stocks = currentCell.stockCount.text!
    }
}
extension ProfileViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DateCollectionViewCell
        cell.dateLabel.text = dateArray[indexPath.row]
        cell.backgroundColor = .backgroundColor
        if selectedIndexPath != nil && indexPath == selectedIndexPath {
            collectionView.cellForItem(at: indexPath)?.setBottomBorder()
            
        }else{
            collectionView.cellForItem(at: indexPath)?.setWhiteBottomBorder()
            
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedRow = collectionView.cellForItem(at: indexPath) as! DateCollectionViewCell
        selectedRow.setBottomBorder()
        self.selectedIndexPath = indexPath
       
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.setWhiteBottomBorder()
        selectedIndexPath = nil
    }
    
}
extension UIView {
    func setBottomBorder() {
        self.layer.backgroundColor = UIColor.backgroundColor.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    func setWhiteBottomBorder() {
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.clear.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.0
        self.layer.shadowRadius = 0.0
    }
}

