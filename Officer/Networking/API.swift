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

class NetworkManager {
    
    private init() {}
    
    static let shared = NetworkManager()
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    func fetch<T: Decodable>(decode model: T.Type, completion: @escaping ((Result<T, Error>) -> Void)) { //bi şeyi fetch edicem ve buna T diyorum.
//        guard let endPoint = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String, let baseURL = URL(string: endPoint) else {
//            return
//        }
        
        guard let url = URL(string: "https://officer-ad6ef-default-rtdb.firebaseio.com/offices.json") else { return }
        
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let response = try self.decoder.decode(model.self, from: data)
                completion(.success(response))
                print(response)
            } catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }.resume()
        
    }
    
}



