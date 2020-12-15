//
//  HistoryDetailsController.swift
//  Assignment 1
//
//  Created by Roman Kantor on 2020-10-09.
//  Copyright © 2020 Roman Kantor. All rights reserved.
//

import UIKit

class HistoryDetailsController: UIViewController {

    var transaction : History?
    
    @IBOutlet weak var item: UITextField!
    @IBOutlet weak var quantity: UITextField!
    @IBOutlet weak var total: UITextField!
    @IBOutlet weak var date: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // assigning all the data from the model to
        //  the local IBOutlets
        item.text = transaction?.type
        quantity.text = "\(transaction?.quantity ?? 0)"
        total.text = transaction?.total
        date.text = transaction?.date
    }
    
}
