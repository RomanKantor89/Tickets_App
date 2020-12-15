//
//  ResetController.swift
//  Assignment 1
//
//  Created by Roman Kantor on 2020-10-09.
//  Copyright © 2020 Roman Kantor. All rights reserved.
//

import UIKit

class ResetController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var myModel : DataModelManager?
    
    @IBOutlet weak var ticketPrice: UILabel!
    @IBOutlet weak var selectedTicketDisplay: UITextField!
    @IBOutlet weak var ticketsRemaining: UILabel!
    @IBOutlet weak var newQuantity: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // close the keyboard with a tap anywhere on the screen
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
   // Number of columns
   func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
    }
       
   // Pickerview number of rows
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return myModel!.allTickets.count
   }
   
   // Populate pickerview
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
       return myModel!.allTickets[row].type
      }
   
   // When picker row selected
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
     {
       selectedTicketDisplay.text = "\(myModel!.allTickets[row].type!)"
       
       if row > 0 {
           ticketsRemaining.text = "\(myModel!.allTickets[row].quantity ?? 0)"
           ticketPrice.text = "$\(myModel!.allTickets[row].price ?? 0)"
           
       }
       else {
        ticketsRemaining.text = "0"
        ticketPrice.text = "0"
       }
     }
    
    // when confirm button clicked
    @IBAction func updateQuantity(_ sender: UIButton) {
        for ticket in myModel!.allTickets {
            if ticket.type == selectedTicketDisplay.text {
                if selectedTicketDisplay.text != "" && selectedTicketDisplay.text != "Select" {
                    ticket.quantity! += Int(newQuantity.text ?? "") ?? 0
                    ticketsRemaining.text = "\(ticket.quantity!)"
                    newQuantity.text = "";
                }
            }
        }
    }
    
}
