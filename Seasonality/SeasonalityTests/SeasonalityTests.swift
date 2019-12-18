//
//  SeasonalityTests.swift
//  SeasonalityTests
//
//  Created by Jack Wong on 12/18/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import XCTest
@testable import Seasonality

class SeasonalityTests: XCTestCase {

    func testEventModelfromJSON() {
        guard let path = Bundle.main.path(forResource: "marketdata", ofType: "json") else { print("No Path To JSON Found"); return }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let retrievedMarkets = try Market.getMarkets(from: data)
            
            guard let markets = retrievedMarkets else { return }
            
            XCTAssert(markets.count == 48, "We have \(markets.count) days of weather listings")
            
        } catch {
            print(error)
            XCTFail()
        }
    }

}
