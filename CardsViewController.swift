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

protocol CardViewSwipeProtocol {
    func swipeToLeftHappened(vc: CardViewController, gr: UIGestureRecognizer)
    func swipeToRightHappened(vc: CardViewController, gr: UIGestureRecognizer)
}

class CardsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let maximumCellSize = CGFloat(150)
    var currentSelectedCellIndex: IndexPath?
    var viewModel: CardsViewModelProtocol!
    var mainFrame: MainFrameProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainFrame = MainFrame()
    }
    
    @IBAction func openRestCard(_ sender: Any) {
        mainFrame.showCardViewController(for: self, cardImageName: viewModel.getRestCardImageName(), bottomText: viewModel.getRestCardBottomText())
    }
    
    @IBAction func openTooMuchTimeCard(_ sender: Any) {
        mainFrame.showCardViewController(for: self, cardImageName: viewModel.getTooMuchTimeCardImageName(), bottomText: viewModel.getTooMuchTimeCardBottomText())
    }
    
    func determineInset() {
        let top = self.collectionView.bounds.height - self.collectionView.collectionViewLayout.collectionViewContentSize.height
        self.collectionView.contentInset = UIEdgeInsets(top: top/2, left: 0, bottom: 0, right: 0)
    }
}

extension CardsViewController: UICollectionViewDataSource {
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
        self.determineInset()
        let restButtonHeader: RestButtonHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "restButtonHeader", for: indexPath) as! RestButtonHeader
        restButtonHeader.restButton.setTitle("RestButton".localized, for: .normal)
        restButtonHeader.tooMuchTimeButton.setTitle("ContinueButton".localized, for: .normal)
        return restButtonHeader
    }
}

extension CardsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = min(collectionView.bounds.width/4-collectionView.contentInset.left-collectionView.contentInset.right-10, maximumCellSize)
        return CGSize(width: cellSize, height: cellSize)
    }
}

extension CardsViewController: CardCellPressedProtocol{
    
    func cardCellPressed(cell: CardCell) {
        if let cellIndexPath = self.collectionView.indexPath(for: cell){
            self.currentSelectedCellIndex = cellIndexPath
            mainFrame.showCardViewController(for: self, cardImageName: self.viewModel.getImageName(at: cellIndexPath.row), bottomText: self.viewModel.getBottomText(at: cellIndexPath.row))
        }
    }
}

extension CardsViewController: CardViewSwipeProtocol {
    
    func setNewValues(to vc: CardViewController, nextCellIndexRow: Int, gr: UIGestureRecognizer) {
        if gr.state == .ended {
            vc.cardImageView.alpha = 0
            UIView.animate(withDuration: 0.3) {
                vc.cardImageView.alpha = 1
                vc.cardImageView.image = UIImage.init(named: self.viewModel.getImageName(at: nextCellIndexRow))
                vc.bottomLabel.text = self.viewModel.getBottomText(at: nextCellIndexRow)
            }
        }
    }
    
    func swipeToLeftHappened(vc: CardViewController, gr: UIGestureRecognizer) {
        if let currentSelectedCellIndex = self.currentSelectedCellIndex?.row {
            if let nextCellIndexRow = self.viewModel.getNextCardIndex(currentCardIndex: currentSelectedCellIndex) {
                self.currentSelectedCellIndex = IndexPath(row: nextCellIndexRow, section: 0)
                self.setNewValues(to: vc, nextCellIndexRow: nextCellIndexRow, gr: gr)
            }
        }
    }
    
    func swipeToRightHappened(vc: CardViewController, gr: UIGestureRecognizer) {
            if let currentSelectedCellIndex = self.currentSelectedCellIndex?.row {
                if let nextCellIndexRow = self.viewModel.getPreviousCardIndex(currentCardIndex: currentSelectedCellIndex) {
                    self.currentSelectedCellIndex = IndexPath(row: nextCellIndexRow, section: 0)
                    self.setNewValues(to: vc, nextCellIndexRow: nextCellIndexRow, gr: gr)
                }
            }

    }
}
