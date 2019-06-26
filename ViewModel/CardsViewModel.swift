//
//  CardModelView.swift
//  AutentiaScrumCards
//
//  Created by Anton Zuev on 28/01/2019.
//

import UIKit

protocol CardsViewModelProtocol {
    
    func getName(at index:Int) -> String
    func getImageName(at index:Int) -> String
    func getRestCardImageName() -> String
    func getTooMuchTimeCardImageName() -> String
    func getRestCardBottomText() -> String
    func getTooMuchTimeCardBottomText() -> String
    func getTypeName() -> String
    func getNumberOfCards()->Int
    func getBottomText(at index: Int) -> String?
}

class CardsViewModel: CardsViewModelProtocol {
    
    private let allCards:[Card]
    private let bottomTexts:[String:String]
    private let typeName:String
    
    func getName(at index:Int) -> String {
        return self.allCards[index].name
    }
    
    func getImageName(at index:Int) -> String {
        return "card_\(self.allCards[index].name)"
    }
    
    func getBottomText(at index: Int)-> String? {
        return bottomTexts[self.allCards[index].name]
    }
    
    func getRestCardImageName() -> String {
        return "restCard"
    }
    
    func getTooMuchTimeCardImageName() -> String {
        return "tooMuchTime"
    }
    
    func getRestCardBottomText() -> String {
        return "RestText".localized
    }
    
    func getTooMuchTimeCardBottomText() -> String {
        return "ContinueText".localized
    }
    
    func getTypeName() -> String {
        return self.typeName
    }
    
    func getNumberOfCards()->Int {
        return self.allCards.count
    }
    
    init(cards: [Card], typeName: String, bottomTexts: [String: String]) {
        self.allCards = cards
        self.typeName = typeName
        self.bottomTexts = bottomTexts
    }
}
