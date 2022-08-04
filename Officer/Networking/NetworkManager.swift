//
//  API.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//



// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let offices = try? newJSONDecoder().decode(Offices.self, from: jsonData)

import Foundation

public extension Bundle {
    /// Returns String value for the specified key from bundle dictionary.
    /// - Parameter key: String representing item key.
    /// - Returns: String value if exists.
    func infoForKey(_ key: String) -> String? {
        (infoDictionary?[key] as? String)?.replacingOccurrences(of: "\\", with: "")
    }

    /// Returns boolean value with specified key from bundle dictionary.
    /// - Parameter key: String representing item key.
    /// - Returns: Boolean value. If key does not exist, `false` will be returned.
    func boolForKey(_ key: String) -> Bool {
        infoForKey(key) == "YES"
    }
}

struct NetworkManager { //Class mı Struct mı olacak?
    
    static let shared = NetworkManager()
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    private init() {}
    
    func fetch<T: Decodable>(decode model: T.Type, completion: @escaping ((Result<T, Error>) -> Void)) { //bi şeyi fetch edicem ve buna T diyorum.
        guard let url = URL(string: Bundle.main.infoForKey("BASE_URL") ?? "") else {
            return
        }
        
        //guard let url = URL(string: "https://officer-ad6ef-default-rtdb.firebaseio.com/offices.json") else { return }
        
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                completion(.failure(error!))
                print(error?.localizedDescription ?? "An Error Occured From data")
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    let apiResponse = try self.decoder.decode(model.self, from: data)
                    completion(.success(apiResponse))
                    print(apiResponse)
                    print(response)
                } catch {
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            } else {
                print("Status code: \((response as! HTTPURLResponse).statusCode)")
            }
        }.resume()
    }
}



