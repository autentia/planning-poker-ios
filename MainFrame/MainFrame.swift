//
//  MainFrame.swift
//  AutentiaScrumCards
//
//  Created by Anton Zuev on 30/01/2019.
//

import UIKit

protocol MainFrameProtocol {
    func showCardsViewController(for segue: UIStoryboardSegue)
    func showCardViewController(for viewController: UIViewController, cardImageName:String, bottomText: String?)
}

class MainFrame: MainFrameProtocol {
    
    func showCardViewController(for viewController: UIViewController, cardImageName: String, bottomText: String?) {
        let cardViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "cardViewController") as! CardViewController
        cardViewController.cardImage = UIImage.init(named: cardImageName)
        cardViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        cardViewController.bottomText = bottomText
        cardViewController.delegate = viewController as? CardViewSwipeProtocol
        viewController.present(cardViewController, animated: true, completion: nil)
    }
    
    func showCardsViewController(for segue: UIStoryboardSegue) {
        if let vc = segue.destination as? CardsViewController{
            if (segue.identifier == "showShirtSizes"){
                vc.viewModel = CardsViewModel(cards: EstimationCardTypes.getSizeOfShirtCards(), typeName: "ShirtSizes".localized, bottomTexts: EstimationCardTypes.getTShirtsBottomTexts())
            }
            else if(segue.identifier == "showFibonacci"){
                vc.viewModel = CardsViewModel(cards: EstimationCardTypes.getFibonacciCards(), typeName: "Fibonacci".localized, bottomTexts: EstimationCardTypes.getFibonacciBottomTexts())
            }
        }
    }
}
