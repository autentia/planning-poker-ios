//
//  CardModelView.swift
//  AutentiaScrumCards
//
//  Created by Anton Zuev on 28/01/2019.
//

import UIKit

class CardsViewModel: NSObject {
    
    private let allCards:[Card]
    
    func getName(at index:Int) -> String {
        return self.allCards[index].name
    }
    
    func getImageName(at index:Int) -> String {
        return "card_\(self.allCards[index].name)"
    }
    
    func getRestCardImageName() -> String {
        return "restCard"
    }
    
    func getTooMuchTimeCardImageName() -> String {
        return "tooMuchTime"
    }
    
    func getNumberOfCards()->Int {
        return self.allCards.count
    }
    
    init(cards: [Card]) {
        self.allCards = cards
    }
}
