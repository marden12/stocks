//
//  StockModel.swift
//  AIFC project
//
//  Created by Dayana Marden on 20.07.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import Foundation
import Alamofire
import SocketIO

enum StockEnum: String{
    case mainColor = "80C783"
    case url = "http://10.101.58.10:3000"
}

enum TimeRangeEnum: String {
    case day = "day"
    case week = "week"
    case month = "month"
    case threeMonth = "threeMonths"
    case halfYear = "halfYear"
    case year = "year"
}


class Socket: NSObject {
    
    
    lazy var socket: SocketIOClient = SocketIOClient(socketURL: URL(string: StockEnum.url.rawValue )!,config: [.forcePolling(true)])
    
    func onStocksOf(_ symbol: String, completion: @escaping (Any) -> ()){
        
        socket.on("connect") {data, ack in
            self.socket.emit("getRealTimeStocks", ["symbol": symbol])
            
            self.socket.on("realTimeStocksInfo/\(symbol)/\(self.socket.sid!)") {data, ack in
                completion(data)
            }
        }
        
        socket.on("error") {data, ack in
            print("error occured")
        }
        
        socket.connect()
    }
    
}

struct StocksModel {
    
    
    static func searchCompany(_ text: String, _ completion: @escaping ([[String: String]]) -> () ){
        
        let parameters: Parameters = [
            "query": "\(text)"
        ]
        
        
        Alamofire.request("https://appstocks.herokuapp.com/searchCompany", parameters: parameters).responseJSON { response in
            
            print("lego")
            
            if let data = response.result.value as? NSArray {
                let result = data.map{ return $0 as! [String: String]}
                completion(result)
                var finalResuts: String = ""
                for result in result{
                    if finalResuts.isEmpty{
                        print("Something rong")
                    }else{
                        finalResuts = (result["des"])!
                    }
                    
                    
                    print(finalResuts)
                    
                }
            
            } else {
                print("no result value")
            }
            
        }
        
    }
    
    static func getGraphPoints(_ symbol: String, type: String, _ completion: @escaping ([Double]) -> () ){
        
        let parameters: Parameters = [
            "symbol": "\(symbol)",
            "type": "\(type)"
        ]
        
        
        Alamofire.request("https://appstocks.herokuapp.com/stocksBySymbol", parameters: parameters).responseJSON { response in
            
            print("lego")
            
            if let data = response.result.value as? NSArray {
                
                let result = data.map{ ($0 as! NSString).doubleValue }
                completion(result)
            
            } else {
                print("no result value")
            }
            
        }
        
    }
    
    
    
    static func stocksFor(_ range: TimeRangeEnum, symbol: String, _ completion: @escaping ([CGFloat],[CGFloat: String]) -> Void ) {
        
        Alamofire.request("\(StockEnum.url.rawValue)/\(range.rawValue)/\(symbol)").responseJSON { response in
            
            if let data = response.result.value as? NSArray{
                
                var dates: [CGFloat: String] = [:]
                
                let points = data.map { (snap) -> CGFloat in
                    
                    let val =  (snap as! NSString).components(separatedBy: "/")
                    
                    let point = CGFloat((val[1] as NSString).doubleValue)
                    
                    dates[point] = val[0]
                    
                    return point
                }
                
                completion(points, dates)
                
            } else {
                print("no result value")
            }
            
        }
        
    }
    
}
