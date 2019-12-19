//
//  MarketFire.swift
//  Seasonality
//
//  Created by Tia Lendor on 12/19/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import Foundation

struct MarketFire {
    
    let name: String
    let address: String
    let operationHours: String
    let operationSeasons: String
    let phoneNumber: String
    let website: String

    
    
    init?(from market: Market) {
        self.name = market.marketName ?? ""
        self.address = market.addressLine1 ?? ""
        self.operationHours = market.operationHours ?? ""
        self.operationSeasons = market.operationSeason ?? ""
        self.phoneNumber = market.phone ?? ""
        self.website = market.marketLink?.url ?? ""

    }
    
    init?(from dict: [String: Any]) {
           guard let name = dict["name"] as? String,
            let address = dict["address"] as? String,
            let operationHours = dict["operationHours"] as? String,
            let operationSeasons = dict["operationSeasons"] as? String,
            let phoneNumber = dict["phoneNumber"] as? String,
            let website = dict["website"] as? String else {
                    return nil
            }

        self.name = name
        self.address = address
        self.operationHours = operationHours
        self.operationSeasons = operationSeasons
        self.phoneNumber = phoneNumber
        self.website = website

        
        
           
       }
    var fieldsDict: [String: Any] {
           return [
            "name": self.name,
            "address": self.address,
            "operationHours": self.operationHours,
            "operationSeasons": self.operationSeasons,
            "phoneNumber": self.phoneNumber,
            "website": self.website

           ]
       }
}
