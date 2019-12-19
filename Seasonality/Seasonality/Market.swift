//
//  Market.swift
//  Seasonality
//
//  Created by Alex 6.1 on 12/18/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import Foundation

struct Market: Codable {
    let county, marketName, location, addressLine1: String?
    let city, state, zip, contact: String?
    let phone: String?
    let marketLink: MarketLink?
    let operationHours, operationSeason, operationMonthsCode, fmnp: String?
    let snapStatus, fc, fca: String?
    let latitude: String?
    let longitude: String?
    let georeference: Georeference?

    enum CodingKeys: String, CodingKey {
        case county
        case marketName = "market_name"
        case location
        case addressLine1 = "address_line_1"
        case city, state, zip, contact, phone
        case marketLink = "market_link"
        case operationHours = "operation_hours"
        case operationSeason = "operation_season"
        case operationMonthsCode = "operation_months_code"
        case fmnp
        case snapStatus = "snap_status"
        case fc, fca, latitude, longitude, georeference
    }
    
    static func getMarkets(from data: Data) throws -> [Market]? {
        do {
            let response = try JSONDecoder().decode([Market].self, from: data)
            return response
        } catch {
            return nil
        }
    }
    
}

// MARK: - Georeference
struct Georeference: Codable {
    let latitude, longitude: String?
}

// MARK: - MarketLink
struct MarketLink: Codable {
    let url: String?
}
