//
//  AddressDecoder.swift
//  Seasonality
//
//  Created by Phoenix McKnight on 12/18/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import Foundation
import CoreLocation

enum LocationFetchingError: Error {
    case error(Error)
    case noErrorMessage
}

class AddressDecoder {
    static let shared = AddressDecoder()
    
    public func addressDecoder(fromAddress address: String, completionHandler: @escaping (Result<CLLocation, LocationFetchingError>) -> Void) {
           DispatchQueue.global(qos: .userInitiated).async {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            if let error = error {
                completionHandler(.failure(LocationFetchingError.error(error)))
            } else {

            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {return}
                completionHandler(.success(location))
            }
            }
        
    }
    }
}
