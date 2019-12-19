//
//  Faved.swift
//  Seasonality
//
//  Created by Tia Lendor on 12/19/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import Foundation

struct Faved: Codable {
    let imageData: String?
  
    
}

/*
 import Foundation

 struct FavedEvents: Codable {
     
     let imageData: String?
     let objectName: String?
     let objectSecondary: String?
     let objectID: String
     let creatorID: String
     let id: String
     //    let eventName: String
 //    let eventStart: String
 //    let eventPrice: String
 //    let eventLink: String
     
    init(imageData: String, objectName: String, objectSecondary: String, objectID: String, creatorID: String) {
         self.imageData = imageData
         self.objectName = objectName
         self.objectSecondary = objectSecondary
         self.objectID = objectID
         self.creatorID = creatorID
     self.id = UUID().description
     }
     
     init?(from dict: [String: Any], id: String) {
         guard let imageData = dict["imageData"] as? String,
             let objectName = dict["objectName"] as? String,
             let objectSecondary = dict["objectSecondary"] as? String,
             let objectID = dict["objectID"] as? String,
             let creatorID = dict["creatorID"] as? String else { return nil }
         
         self.imageData = imageData
         self.objectName = objectName
         self.objectSecondary = objectSecondary
         self.objectID = objectID
         self.creatorID = creatorID
         self.id = id

     }
     
     var fieldsDict: [String: Any] {
         return [
             "imageData": self.imageData ?? "",
             "objectName": self.objectName ?? "",
             "objectSecondary": self.objectSecondary ?? "",
             "objectID": self.objectID,
             "creatorID": self.creatorID
         ]
     }
 }
 */
