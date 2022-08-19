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
                var id: Int16?
                var name: String?
                var address: String?
                var capacity: String?
                var rooms: String?
                var space: String?
                var image: String?
                
                 init(id: Int16? = nil, name: String? = nil, address: String? = nil, capacity: String? = nil, rooms: String? = nil, space: String? = nil, image: String? = nil) {
                    self.id = id
                    self.name = name
                    self.address = address
                    self.capacity = capacity
                    self.rooms = rooms
                    self.space = space
                    self.image = image
                }
                
                init(office: Offices) {
                    self.init(id: office.id,
                              name: office.name,
                              address: office.address,
                              capacity: office.capacity,
                              rooms: office.rooms,
                              space: office.space,
                              image: office.image)
                }
                
            }
            
        }
        
    }
    
}
// swiftlint:enable nesting
