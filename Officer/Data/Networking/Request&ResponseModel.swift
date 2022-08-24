

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let offices = try? newJSONDecoder().decode(Offices.self, from: jsonData)

import Foundation




// MARK: - Office
struct OfficeData: Codable {
    public init(address: String?, capacity: String?, id: Int?, image: String?, images: [String]?, location: Location?, name: String?, rooms: Int?, space: String?) {
        self.address = address
        self.capacity = capacity
        self.id = id
        self.image = image
        self.images = images
        self.location = location
        self.name = name
        self.rooms = rooms
        self.space = space
    }
    
    let address, capacity: String?
    let id: Int?
    let image: String?
    let images: [String]?
    let location: Location?
    let name: String?
    let rooms: Int?
    let space: String?
}

// MARK: - Location
struct Location: Codable {
    let latitude, longitude: Double?
}

typealias OfficeDataArray = [OfficeData]
