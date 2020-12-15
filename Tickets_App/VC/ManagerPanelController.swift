//
//  ManagerPanelController.swift
//  Assignment 1
//
//  Created by Roman Kantor on 2020-10-09.
//  Copyright © 2020 Roman Kantor. All rights reserved.
//

import UIKit

class ManagerPanelController: UIViewController {

    var myModel : DataModelManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // Before going to either history or reset
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "history" {
            // initializer for history
            let historyController : HistoryController = segue.destination as! HistoryController
            historyController.myModel = myModel!
        }
        else if segue.identifier == "reset" {
            // initializer for reset
            let resetController : ResetController = segue.destination as! ResetController
            resetController.myModel = myModel!
        }
        
    }
    
}
