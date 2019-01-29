//
//  ViewController.swift
//  AutentiaScrumCards
//
//  Created by Anton Zuev on 25/01/2019.
//

import UIKit

protocol CardCellPressedProtocol {
    func cardCellPressed(cell:CardCell)
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let modelView = CardsViewModel(cards: numericCards)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setShadow(view:UIView?) {
        //view?.layer.shadowColor = UIColor.black.cgColor
//        view?.layer.shadowOffset = CGSize(width: 1.0, height: 3.0)
//        view?.layer.shadowRadius = 4.0
//        view?.layer.shadowOpacity = 0.6
        view?.layer.cornerRadius = 8.0
        view?.layer.masksToBounds = false
    }
    
    @IBAction func openRestCard(_ sender: Any) {
        let cardViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "cardViewController") as! CardViewController
        cardViewController.cardImage = UIImage.init(named: modelView.getRestCardImageName())
        cardViewController.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        self.present(cardViewController, animated: true, completion: nil)
    }
}


extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelView.getNumberOfCards();
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Card", for: indexPath) as! CardCell
        cell.delegate = self
        self.setShadow(view: cell.cardCellButton)
        cell.cardCellButton.setTitle(modelView.getName(at: indexPath.row), for: UIControl.State.normal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let restButtonHeader: RestButtonHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "restButtonHeader", for: indexPath) as! RestButtonHeader
        // configure footer view
        self.setShadow(view: restButtonHeader.restButton)
        return restButtonHeader
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }
}

extension MainViewController: CardCellPressedProtocol{
    
    func cardCellPressed(cell: CardCell) {
        if let cellIndexPath = self.collectionView.indexPath(for: cell){
            let cardViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "cardViewController") as! CardViewController
            cardViewController.cardImage = UIImage(named: self.modelView.getImageName(at: (cellIndexPath.row)))
            cardViewController.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
            self.present(cardViewController, animated: true, completion: nil)
        }
    }
}
