//
//  MarketAPIClient.swift
//  Seasonality
//
//  Created by Alex 6.1 on 12/18/19.


import Foundation

struct MarketAPIClient {
    static let manager = MarketAPIClient()
    
    func getMarkets(city: String?,
                    lat: Double,
                    long: Double,
                    completionHandler: @escaping (Result<[Market], AppError>) -> Void) {
        var urlString = ""
        
        if let city = city {
            urlString = "https://data.ny.gov/resource/qq4h-8p86.json?city=\(city)"
        } else {
             
            urlString = "https://data.ny.gov/resource/qq4h-8p86.json?$where=within_circle(georeference,\(lat),\(long),3000)"
        }
        
        print(urlString)
        
        guard let url = URL(string: urlString) else {
            fatalError("bad URL")
        }
        
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case let .failure(error): completionHandler(.failure(error))
                return
            case let .success(data):
                do {
                    let Markets = try Market.getMarkets(from: data)
                    completionHandler(.success(Markets ?? []))
                }
                catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
    
    private init() {}
}
