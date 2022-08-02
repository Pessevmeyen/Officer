//
//  API.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import Foundation


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let offices = try? newJSONDecoder().decode(Offices.self, from: jsonData)

import Foundation




struct NetworkManager {
    let officeURL = "https://www.postman.com/collections/a5c662be0d7096bdbdea"
    
    func fetchOffice(officeName: String) {
        let urlString = "\(officeURL)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        //1. Create a URL
        if let baseURL = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: baseURL) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(officesData: safeData)
                }
                
                
            }
            //4. Start the task
            task.resume()
            
        }
    }
    
    func parseJSON(officesData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(OfficesData.self, from: officesData)
            print(decodedData.name)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}
