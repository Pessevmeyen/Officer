

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let offices = try? newJSONDecoder().decode(Offices.self, from: jsonData)

import Foundation




// MARK: - Office
struct OfficeData: Codable {
    let address, capacity: String?
    let id: Int?
    let bool: Bool?
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
