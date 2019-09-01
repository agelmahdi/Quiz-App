//
//  Questions.swift
//  Quiz App
//
//  Created by Ahmed El-Mahdi on 8/20/19.
//  Copyright © 2019 Ahmed El-Mahdi. All rights reserved.
//

import Foundation
struct Questions : Codable{
    var question:String?
    var answers:[String]
    var correctAnswerIndex:Int?
    var feedback:String?
}
