//
//  CompanyViewController.swift
//  AIFC project
//
//  Created by Dayana Marden on 10.07.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography
import ScrollableGraphView

class CompanyViewController: UIViewController {
    
    var selectedIndexPath: IndexPath?
    var nameOfCompany = ""
    var costOfStock = ""
    var stocks = ""
    var dateArray = ["1D","1W","1M","3M","6M","1Y"]
    var pointsArray:[Double] = []
    var type = ""
    
    var dayPointsArray:[Double] = []
    var weekPointsArray:[Double] = []
    var monthPointsArray:[Double] = []
    var threeMonthsPointsArray:[Double] = []
    var sixMonthsPointsArray:[Double] = []
    var yearPointsArray:[Double] = []

    
    fileprivate lazy var  containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        return view
    }()
    fileprivate lazy var graphView: CustomGraphView = {
        let view = CustomGraphView()
        view.data = self.pointsArray
        return view
    }()
    fileprivate lazy var cashView: CustomCashView = {
        let view = CustomCashView()
        return view
    }()
    fileprivate lazy var companiesIncome: CompaniesIncomeView = {
        let view = CompaniesIncomeView()
        view.text = self.costOfStock
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
//    fileprivate lazy var openTableButton: UIButton = {
//        let button = UIButton()
//        button.setImage(#imageLiteral(resourceName: "down-arrow"), for: .normal)
//        button.addTarget(self, action: #selector(openListOfStocks(_:)), for: .touchUpInside)
//        return button
//    }()
    fileprivate lazy var buyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.setTitle("Buy", for: .normal)
        button.addTarget(self, action: #selector(tradeVC(_:)), for: .touchUpInside)
        button.setTitleColor(.backgroundColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 24)
        button.tag = 1
        return button
    }()
    fileprivate lazy var sellButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.setTitle("Sell", for: .normal)
        button.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 24)
        button.addTarget(self, action: #selector(tradeVC(_:)), for: .touchUpInside)
        button.setTitleColor(.backgroundColor, for: .normal)
        button.tag = 2
        return button
    }()
    fileprivate lazy var navBar: UINavigationBar = {
        var navBar = UINavigationBar()
        navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        return navBar
    }()
    
    fileprivate lazy var listOfCompanies: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = self.containerView
        tableView.rowHeight = 90
//        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.sectionHeaderHeight = 50
        return tableView
    }()


    fileprivate lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        button.addTarget(self, action: #selector(goToProfileViewController(_:)), for: .touchUpInside)
        return button
    }()
    fileprivate lazy var nameOfCompanyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Standart.font.rawValue, size: 24)
        
        return label
    }()
        override func viewDidLoad() {

            setupViews()
            setupConstraints()
            
            
        
    }
    override func viewWillAppear(_ animated: Bool) {
        nameOfCompanyLabel.text = nameOfCompany
        fetchALL()
        fetchGraph(newType: "day")
        
    }

    func setupViews(){
        navBar.addSubview(closeButton)
        view.addSubview(listOfCompanies)
        view.addSubview(navBar)
        
        containerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        containerView.addSubview(companiesIncome)
        containerView.addSubview(sellButton)
        containerView.addSubview(buyButton)
//        containerView.addSubview(openTableButton)
        navBar.addSubview(nameOfCompanyLabel)
        view.addSubview(collectionView)
    }
    
    func setupConstraints(){
        constrain(view,listOfCompanies,containerView,companiesIncome,collectionView){ v,list,container,income,collectionView in
            list.edges == v.edges
            income.top == container.top + 64
            income.centerY == container.centerY
            income.width == container.width
            income.height == container.height/4
            

        }
        constrain(collectionView,sellButton,containerView,buyButton,closeButton){ collectionView,sb,view,bb,cb in
    
            sb.width == collectionView.width/2.5
            sb.height == 45
            sb.left == view.left + 24
            sb.bottom == view.bottom - 64
            
            bb.width == collectionView.width/2.5
            bb.height == 45
            bb.right == view.right - 24
            bb.bottom == view.bottom - 64
            
            collectionView.width == view.width
            collectionView.height == 64
            collectionView.bottom == sb.top - 32
            collectionView.centerX == view.centerX
        }
//        constrain(view,containerView){ button,v,container in
//            button.bottom == container.bottom - 10
//            button.width == 24
//            button.height == 24
//            button.centerX == v.centerX
//            
//        }
        constrain(navBar,closeButton,nameOfCompanyLabel){ nav,cb,label in
            cb.width == 24
            cb.height == 24
            cb.left == nav.left + 16
            cb.top == nav.top + 26
            label.centerY == cb.centerY
            label.centerX == nav.centerX
        }
        
    }
    func constraintsToGraph(){
        constrain(collectionView,containerView,graphView,companiesIncome){ collectionView,v,graphView,income in
            graphView.top == income.top + 8
            graphView.centerX == v.centerX
            graphView.width == v.width - 16
            graphView.height == v.height/2
            
        }
    }
//    func openListOfStocks(_:UIButton){
//        let indexPath = NSIndexPath(item: 0, section: 0)
//        listOfCompanies.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
//
//    }
    
    func goToProfileViewController(_: UIButton){
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    func tradeVC(_ sender: UIButton){
        let tradeViewController = TradeViewController()
        let sellViewController = SellStocksViewController()
        if sender.tag == 1{
            self.present(tradeViewController, animated: true, completion: nil)
            tradeViewController.name = nameOfCompanyLabel.text!
        }else if sender.tag == 2{
            self.present(sellViewController, animated: true, completion: nil)
            sellViewController.name = nameOfCompanyLabel.text!
            sellViewController.stocks = stocks
            
        }
        
    }
    func fetchGraph(newType: String){
        StocksModel.getGraphPoints(nameOfCompanyLabel.text!, type: newType) { points in
            self.graphView.maxRange = points.min()!
            self.graphView.minRange = points.max()!
            self.graphView.data = points
            self.containerView.addSubview(self.graphView)
            self.constraintsToGraph()
        }
    }
    func drawGraph(array: [Double]){
        
        self.graphView.minRange = array.min()!
        self.graphView.maxRange = array.max()!
        self.graphView.data = array
        self.containerView.addSubview(self.graphView)
        self.constraintsToGraph()
    }
    
    func fetchALL(){
        StocksModel.getGraphPoints(nameOfCompanyLabel.text!, type: "day") { points in
            self.dayPointsArray = points
        }
        StocksModel.getGraphPoints(nameOfCompany, type: "week") { points in
            self.weekPointsArray = points
        }
        StocksModel.getGraphPoints(nameOfCompany, type: "month") { points in
            self.monthPointsArray = points
        }
        StocksModel.getGraphPoints(nameOfCompany, type: "threeMonths") { points in
            self.threeMonthsPointsArray = points
        }
        StocksModel.getGraphPoints(nameOfCompany, type: "halfYear") { points in
            self.sixMonthsPointsArray = points
        }
        StocksModel.getGraphPoints(nameOfCompany, type: "year") { points in
            self.yearPointsArray = points
        }
        
    }
}

extension CompanyViewController: UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0) {
            return 5
        }else if(section == 1){
            return 3
        }else if(section == 2){
            return 4
        }
        return 1

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) 
//        if(indexPath.section == 0) {
//
//
//        }else if(indexPath.section == 1){
//         
//        }else if(indexPath.section == 2){
//          
//        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0) {
            return "News"
        }else if(section == 1){
            return "Statistics"
        }else if(section == 2){
            return "Orders"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .lightgray
    }
}
extension CompanyViewController: UICollectionViewDelegate,UICollectionViewDataSource{
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
        if self.dayPointsArray.isEmpty || self.weekPointsArray.isEmpty || self.monthPointsArray.isEmpty || self.threeMonthsPointsArray.isEmpty || self.sixMonthsPointsArray.isEmpty || self.yearPointsArray.isEmpty{
            print("Waiting please")
        }else{
            if selectedRow.dateLabel.text == "1D"{
                drawGraph(array: self.dayPointsArray)
            }else if selectedRow.dateLabel.text == "1W"{
                drawGraph(array: self.weekPointsArray)
            }else if selectedRow.dateLabel.text == "1M"{
                drawGraph(array: self.monthPointsArray)
            }else if selectedRow.dateLabel.text == "3M"{
                drawGraph(array: self.threeMonthsPointsArray)
            }else if selectedRow.dateLabel.text == "6M"{
                drawGraph(array: self.sixMonthsPointsArray)
            }else if selectedRow.dateLabel.text == "1Y"{
                drawGraph(array: self.yearPointsArray)
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.setWhiteBottomBorder()
        selectedIndexPath = nil
    }
    
}
