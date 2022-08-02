//
//  OfficeViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//



// MARK: - Office datas
struct OfficesData: Decodable {
    let address, capacity: String?
    let id: Int?
    let image: String?
    let location: Location?
    let name: String?
    let rooms: Int?
    let space: String?
}

// MARK: - Location
struct Location: Decodable {
    let latitude, longitude: Double?
}

typealias Offices = [Office]
