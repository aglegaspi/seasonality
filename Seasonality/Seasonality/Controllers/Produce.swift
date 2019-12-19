//
//  Produce.swift
//  Seasonality
//
//  Created by Alex 6.1 on 12/18/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import Foundation

struct Produce {
    let name: String
    let item: String
    let description: String
    let image: String
    
    
    init?(from dict: [String: Any], item: String) {
           guard let description = dict["Description"] as? String,
                let image = dict["imageUrl"] as? String,
                let name = dict["name"] as? String else {
                       return nil
               }
        self.item = item
        self.description = description
        self.image = image
        self.name = name
        
           
       }
}
