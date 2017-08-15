//
//  PersonaInformation.swift
//  AIFC project
//
//  Created by Dayana Marden on 11.08.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import Foundation
import Firebase
struct PersonalInformation {
    let name: String
    let balance: String
    let ref: DatabaseReference?
    
    init(name: String,balance: String) {
        self.name = name
        self.balance = balance
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        balance = snapshotValue["balance"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "balance": balance
        ]
    }

}
