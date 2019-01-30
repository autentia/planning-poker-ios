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
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: CardsViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.titleLabel.text = viewModel.getTypeName()
    }
    
    func openCardImageViewController(cardImageName: String) {
        let cardViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "cardViewController") as! CardViewController
        cardViewController.cardImage = UIImage.init(named: cardImageName)
        cardViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(cardViewController, animated: true, completion: nil)
    }
    
    @IBAction func openRestCard(_ sender: Any) {
        self.openCardImageViewController(cardImageName: viewModel.getRestCardImageName())
    }
    
    @IBAction func openTooMuchTimeCard(_ sender: Any) {
        self.openCardImageViewController(cardImageName: viewModel.getTooMuchTimeCardImageName())
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfCards();
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Card", for: indexPath) as! CardCell
        cell.delegate = self
        cell.cardCellButton.setTitle(viewModel.getName(at: indexPath.row), for: UIControl.State.normal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let restButtonHeader: RestButtonHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "restButtonHeader", for: indexPath) as! RestButtonHeader
        return restButtonHeader
    }
}

//extension MainViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cellSize = collectionView.contentSize.width/3-collectionView.contentInset.left-collectionView.contentInset.right-10
//        return CGSize(width: cellSize, height: cellSize)
//    }
//}

extension MainViewController: CardCellPressedProtocol{
    
    func cardCellPressed(cell: CardCell) {
        if let cellIndexPath = self.collectionView.indexPath(for: cell){
            self.openCardImageViewController(cardImageName: self.viewModel.getImageName(at: cellIndexPath.row))
        }
    }
}
