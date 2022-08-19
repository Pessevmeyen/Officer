//
//  FavoriteScreenModels.swift
//  Officer
//
//  Created by Furkan Eruçar on 14.08.2022.
//

import Foundation

// swiftlint:disable nesting
enum FavoriteScreen {
    
    enum Fetch {
        
        struct Request {
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
            let coreDataOfficesViewModel: [FavoriteScreen.Fetch.ViewModel.CoreDataModels]
            
            struct CoreDataModels {
                var idArray: [Int]?
                var nameArray: [String]?
                var addressArray: [String]?
                var capacityArray: [String]?
                var roomsArray: [String]?
                var spaceArray: [String]?
                var imageArray: [String]?
                
                init(idArray: [Int], nameArray: [String], addressArray: [String], capacityArray: [String], roomsArray: [String], spaceArray: [String], imageArray: [String]) {
                    self.idArray = idArray
                    self.nameArray = nameArray
                    self.addressArray = addressArray
                    self.capacityArray = capacityArray
                    self.roomsArray = roomsArray
                    self.spaceArray = spaceArray
                    self.imageArray = imageArray
                
            }
        }
        
    }
    
}
    
}
// swiftlint:enable nesting
