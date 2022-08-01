//
//  OfficeResponseModel.swift
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

struct OfficeResponseModel {
    let feed: Feed?
}

struct Feed {
    let results: [Offices]?
}

// MARK: - Offices
struct Offices {
    let info: Info?
    let item: [Item]?
}

// MARK: - Info
struct Info {
    let postmanID, name: String?
    let schema: String?
}

// MARK: - Item
struct Item {
    let name, id: String?
    let request: Request?
    let response: [Any?]?
}

// MARK: - Request
struct Request {
    let method: String?
    let header: [Any?]?
    let url: String?
    let body: Body?
}

// MARK: - Body
struct Body {
    let mode, raw: String?
    let options: Options?
}

// MARK: - Options
struct Options {
    let raw: Raw?
}

// MARK: - Raw
struct Raw {
    let language: String?
}

