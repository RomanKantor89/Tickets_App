//
//  HistoryModel.swift
//  Assignment 1
//
//  Created by Roman Kantor on 2020-10-07.
//  Copyright © 2020 Roman Kantor. All rights reserved.
//

import Foundation

class History : Ticket{
    
    var date : String?
    var total : String?
    
    init(t:String, q:Int, d:String, tot: String) {
        super.init()
        
        type = t
        quantity = q
        date = d
        total = tot
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
