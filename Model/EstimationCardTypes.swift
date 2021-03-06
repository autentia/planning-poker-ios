//
//  EstimationTypeCardType.swift
//  AutentiaScrumCards
//
//  Created by Anton Zuev on 30/01/2019.
//

import UIKit

class EstimationCardTypes: NSObject {
    
    static func getFibonacciCards() -> [Card] {
        return [Card(name: "0"),
                Card(name: "0,5"),
                Card(name: "1"),
                Card(name: "2"),
                Card(name: "3"),
                Card(name: "5"),
                Card(name: "8"),
                Card(name: "13"),
                Card(name: "20"),
                Card(name: "40"),
                Card(name: "100"),
                Card(name: "∞")]
    }
    
    static func getSizeOfShirtCards() -> [Card] {
        return [Card(name: "XXS"),
                Card(name: "XS"),
                Card(name: "S"),
                Card(name: "M"),
                Card(name: "L"),
                Card(name: "XL"),
                Card(name: "XXL"),
                Card(name: "∞")]
        
    }
    
    static func getTShirtsBottomTexts() -> [String: String] {
        return ["∞": "InfinityText".localized]
    }
    
    static func getFibonacciBottomTexts() -> [String: String] {
        return ["0": "DoneText".localized, "∞": "InfinityText".localized]
    }
    
    
}
