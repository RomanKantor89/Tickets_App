//
//  TicketModel.swift
//  Assignment 1
//
//  Created by Roman Kantor on 2020-10-07.
//  Copyright © 2020 Roman Kantor. All rights reserved.
//

import Foundation

class Ticket: Codable {
    
    var type : String?
    var price : Double?
    var quantity : Int?
    
    init() {
        type = ""
        price = 0.0
        quantity = 0
    }
    
    init(t:String, p:Double, q:Int) {
        type = t
        price = p
        quantity = q
    }
}

class TicketPackage: Codable {
    var season: String
    var data: [Ticket]
}
