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
        return "carta_\(self.allCards[index].name)_cc"
    }
    
    func getRestCardImageName() -> String {
        return "carta_¿Descansamos?_cc"
    }
    
    func getNumberOfCards()->Int {
        return self.allCards.count
    }
    
    init(cards: [Card]) {
        self.allCards = cards
    }
}
