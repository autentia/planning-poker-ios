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
    func getNextImageName(currentImageName: String) -> String?
    func getNextBottomText(currentImageName: String) -> String?
    func getNextCardIndex(currentCardIndex: Int) -> Int?
    func getPreviousCardIndex(currentCardIndex: Int) -> Int?
}

class CardsViewModel: CardsViewModelProtocol {
    
    private let allCards: [Card]
    private let bottomTexts: [String:String]
    private let typeName: String
    
    func getNextCardIndex(currentCardIndex: Int) -> Int? {
        let nextCellIndexRow = currentCardIndex + 1
        if nextCellIndexRow >= 0 && nextCellIndexRow < self.allCards.count {
            return nextCellIndexRow
        } else {
            return nil
        }
    }
    
    func getPreviousCardIndex(currentCardIndex: Int) -> Int? {
        let nextCellIndexRow = currentCardIndex - 1
        if nextCellIndexRow >= 0 && nextCellIndexRow < self.allCards.count {
            return nextCellIndexRow
        } else {
            return nil
        }
    }
    
    func getName(at index:Int) -> String {
        return self.allCards[index].name
    }
    
    func getImageName(at index:Int) -> String {
        return "card_\(self.allCards[index].name)"
    }
    
    func getBottomText(at index: Int) -> String? {
        return bottomTexts[self.allCards[index].name]
    }
    
    func getNextImageName(currentImageName: String) -> String? {
        let cardName = currentImageName.split(separator: "_").dropFirst()
        let foundCard = self.allCards.first(where: {$0.name == cardName[0]})
        if let foundCard = foundCard {
            return "card_\(foundCard.name)"
        } else {
            return nil
        }
    }
    
    func getNextBottomText(currentImageName: String) -> String? {
        let cardName = currentImageName.split(separator: "_").dropFirst()
        let foundBottomText = self.bottomTexts[String(cardName[0])]
        return foundBottomText
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
