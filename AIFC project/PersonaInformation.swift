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
    let purse: String
    let ref: DatabaseReference?
    
    init(name: String,purse: String) {
        self.name = name
        self.purse = purse
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        purse = snapshotValue["purse"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "purse": purse
        ]
    }

}
