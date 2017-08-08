//
//  OwnStocks.swift
//  AIFC project
//
//  Created by Dayana Marden on 31.07.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct OwnStock {
    
    let key: String
    let name: String
    let price: String
    let stocks: String
    let ref: DatabaseReference?
    
    init(name: String, price: String, stocks: String, key: String = "") {
        self.key = key
        self.name = name
        self.price = price
        self.stocks = stocks
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        stocks = snapshotValue["stocks"] as! String
        price = snapshotValue["price"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "price": price,
            "stocks": stocks
        ]
    }
    
}
