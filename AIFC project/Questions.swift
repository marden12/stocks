//
//  Questions.swift
//  AIFC project
//
//  Created by Dayana Marden on 26.07.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

struct Topic{
    var id: Int
    var name: String
    var description: String?
}
struct Question{
    var id: Int
    var text: String
    var answers : [String]
    var rightAnswerIndex : Int8
    var helper: String?
    var difficulty: Int
    var topic : Topic
}

struct Result{
    var q: Question
    var isRight: Bool?
    var startTime: Date
    var finishTime: Date?
    var didAnswer : Bool
}


extension Question {


}


