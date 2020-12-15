//
//  DataModelManager.swift
//  Assignment 1
//
//  Created by Roman Kantor on 2020-10-07.
//  Copyright © 2020 Roman Kantor. All rights reserved.
//

import Foundation
import UIKit

class DataModelManager {
    var allTicketPackages = [TicketPackage]()
    var allTickets = [Ticket]()
    var allHistory = [History]()
    
    // API to fetch the data from Github
    func fetchJSONData( completionHandler : @escaping (TicketPackage)->Void )  {

        let url = URL(string: "https://raw.githubusercontent.com/RomanKantor89/iOS_json_data/main/tickets.json")!
               
           // calling the url
           let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
               
               // If there is an error, then "error" will have something in it
               // Otherwise, it will be nil
               if let error = error {
                   print(error)
                   return
               }
               
               // check HTTP response status for error codes
               guard let httpResponse = response as? HTTPURLResponse,
                   (200...299).contains(httpResponse.statusCode)
                   else {
                       // Show the URL and response status code in the debug console
                       if let httpResponse = response as? HTTPURLResponse {
                           print("URL: \(httpResponse.url!.path )\nStatus code: \(httpResponse.statusCode)")
                       }
                       return
               }
               
               // Ensure that three conditions are met (multiple if-let)...
               // 1. Non-nil Content-Type header
               // 2. Content-Type starts with "text/plain"
               // 3. Data is non-nil
               if let mimeType = httpResponse.mimeType,
                   mimeType.starts(with: "text/plain"),
                   let data = data {
                   
                       // Create and configure a JSON decoder
                       let decoder = JSONDecoder()
                       //decoder.dateDecodingStrategy = .iso8601
                       
                       // Attempt to decode the data into a "TicketPackage" object
                       do {
                        let result = try decoder.decode(TicketPackage.self, from: data)
                           // Call the closure method
                           completionHandler(result)
                       }
                       catch {
                           print(error)
                       }
               }
           }
           
           // execute the task
           task.resume()
    }
    
    
    // method to add ticket purchase transactions
    func addHistory (H: History){
        allHistory.append(H)
    }
}
