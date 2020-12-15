//
//  HistoryController.swift
//  Assignment 1
//
//  Created by Roman Kantor on 2020-10-09.
//  Copyright © 2020 Roman Kantor. All rights reserved.
//

import UIKit

class HistoryController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var myModel : DataModelManager?
    
    @IBOutlet weak var tabView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Before moving to HistoryDetailsController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let historyDetailController : HistoryDetailsController = segue.destination as! HistoryDetailsController

        if let i = tabView.indexPathForSelectedRow {
            historyDetailController.transaction = myModel!.allHistory[i.row]
        }
    }
    
    // creates a table with the specified amount of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myModel!.allHistory.count;
    }
    
    // populating the table with the history 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "\(myModel!.allHistory[indexPath.row].type ?? "")"
        cell?.detailTextLabel?.text = "\(myModel!.allHistory[indexPath.row].quantity ?? 0)"
        return cell!;
    }
    
}
