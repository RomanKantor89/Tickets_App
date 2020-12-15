//
//  ViewController.swift
//  Assignment 1
//
//  Created by Roman Kantor on 2020-10-07.
//  Copyright © 2020 Roman Kantor. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var myModel : DataModelManager?

    // Displays
    @IBOutlet weak var selectedTicketDisplay: UITextField!
    @IBOutlet weak var totalPrice: UITextField!
    @IBOutlet weak var ticketQty: UITextField!
    @IBOutlet weak var ticketsRemaining: UITextField!
    @IBOutlet weak var ticketPrice: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var currentView: UINavigationItem!
    var ticketCounter : Int = 0
    
    // buttons
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // call the API on the start to get initial data
        fetchData()
    }
    
    // completion handler to save the data received from the API
    func fetchData() {
       myModel?.fetchJSONData { (ticketsPackage) in
           DispatchQueue.main.async {
            self.myModel?.allTicketPackages.append(ticketsPackage)
            self.myModel?.allTickets = self.myModel?.allTicketPackages[0].data as! [Ticket]
            
            // reload the picker and update view title
            self.picker.reloadAllComponents()
            self.currentView.title = self.myModel?.allTicketPackages[0].season
           }
       }
    }
    
    // Before moving to Manager Panel
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let managerPanelController : ManagerPanelController = segue.destination as! ManagerPanelController
        
        managerPanelController.myModel = myModel!
    }
    
    // Pickerview number of columns
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
            
            // reset the values when ticket type switched
            resetPressed(resetButton)
        }
        else {
           ticketsRemaining.text = "0"
            ticketPrice.text = "0"
        }
      }
    
    // Calculate the total price for the tickets
    func calculateTotal(){
        for ticket in myModel!.allTickets {
            if ticket.type == selectedTicketDisplay.text {
                totalPrice.text = "$\(Double(ticketCounter) * ticket.price!)"
            }
        }
    }
    
    // Adds plus one to the ticket counter
    @IBAction func addOneTicket(_ sender: UIButton) {
        ticketCounter+=1;
        ticketQty.text = "\(ticketCounter)";
        
        calculateTotal()
    }
    
    // Removes one from the ticket counter
    @IBAction func removeOneTicket(_ sender: UIButton) {
        if ticketCounter > 0 {
            ticketCounter-=1;
        }
        ticketQty.text = "\(ticketCounter)";
        
        calculateTotal()
    }
    
    // Handles all the numeric buttons
    @IBAction func digitPressed(_ sender: UIButton) {
        let digit = sender.currentTitle;
        
        if ticketQty.text != "0"{
            ticketQty.text! += digit ?? "";
        }
        else {
            ticketQty.text = digit;
        }
        
        ticketCounter = Int(ticketQty.text ?? "") ?? 0;
        
        calculateTotal()
    }
    
    // resets the total price, the ticket quantity and errors
    @IBAction func resetPressed(_ sender: UIButton) {
        ticketCounter = 0;
        totalPrice.text = "0";
        ticketQty.text = "0";
        errorLabel.text = "";
    }
    
    // handles the purchase process when buy button pressed
    @IBAction func buyPressed(_ sender: UIButton) {
        
        // check if all the required fields selected
        if (selectedTicketDisplay.text != nil ) && (totalPrice.text != "0" ) && (totalPrice.text != nil) && ticketCounter > 0{
            
            var validPurchase : Bool = false;
            errorLabel.text = ""
            
            // Reduce total amount of tickets
            for  ticket in myModel!.allTickets {
                if ticket.type == selectedTicketDisplay.text
                && ticket.quantity! >= ticketCounter{
                    validPurchase = true;
                    ticket.quantity! -= ticketCounter;
                    ticketsRemaining.text = "\(ticket.quantity!)"
                }
            }
            
            // validPurchase verifies that there is enough tickets remaining in selected category
            if validPurchase {
              // Format the date
              let formatter = DateFormatter()
              formatter.timeStyle = .short
              formatter.dateStyle = .long
              formatter.timeZone = TimeZone.current
              
              let currentDate = formatter.string(from: Date())

              // Create transaction
              let transaction = History(t: selectedTicketDisplay.text!, q: ticketCounter, d: currentDate, tot: totalPrice.text!);
              
              // Add the transaction to the history model
              myModel!.addHistory(H: transaction)
              resetPressed(resetButton)
            }
            else {
                errorLabel.text = "Not enough tickets in this category!"
            }
        }
        else {
            errorLabel.text = "Select ticket type and quantity"
        }
        
    }
    
}

