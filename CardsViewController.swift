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
    func panGestureHappened(vc: CardViewController, gr: UIPanGestureRecognizer)
}

class CardsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let maximumCellSize = CGFloat(150)
    var currentSelectedCellIndex: IndexPath?
    var viewModel: CardsViewModelProtocol!
    var mainFrame: MainFrameProtocol!
    
    var firstX = CGFloat(0)
    var firstY = CGFloat(0)
    var nextCardView: UIView?
    var previousCardView: UIView?
    
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
    
    func panGestureHappened(vc: CardViewController, gr: UIPanGestureRecognizer) {
        let translation = gr.translation(in: vc.view)
        if gr.state == .began {
            firstX = vc.cardImageView.center.x
            firstY = vc.cardImageView.center.y
            vc.cardImageView.center = CGPoint(x: firstX + translation.x, y: firstY)
            self.previousCardView = self.addPreviousCardView(to: vc, gr: gr)
            self.nextCardView = self.addNextCardView(to: vc, gr: gr)
        } else if gr.state == .changed {
            vc.cardImageView.center = CGPoint(x: firstX + translation.x, y: firstY)
            if translation.x > 25 {
                self.previousCardView?.alpha = abs(gr.translation(in: vc.view).x/vc.view.bounds.width)
                self.previousCardView?.center = CGPoint(x: firstX - vc.view.bounds.width * 0.7 + translation.x, y: firstY)
            } else if translation.x < -25 {
                 self.nextCardView?.center = CGPoint(x: firstX + vc.view.bounds.width * 0.7 + translation.x, y: firstY)
                self.nextCardView?.alpha = abs(gr.translation(in: vc.view).x/vc.view.bounds.width)
            }
        } else if gr.state == .ended {
            vc.cardImageView.center = CGPoint(x: firstX, y: firstY)
            self.nextCardView?.removeFromSuperview()
            self.nextCardView = nil
            self.previousCardView?.removeFromSuperview()
            self.previousCardView = nil
            if translation.x > 100 {
                self.swipeToRightHappened(vc: vc, gr: gr)
            } else if translation.x < -100 {
                self.swipeToLeftHappened(vc: vc, gr: gr)
            }
        } else {
            vc.cardImageView.center = CGPoint(x: firstX, y: firstY)
        }
    }
    
    
    func createAndAddCardImageView(imageName: UIImage?, bounds: CGRect, parentView: UIView) -> UIView? {
        let cardView = UIImageView(image: imageName)
        cardView.alpha = 0
        cardView.contentMode = .scaleAspectFit
        cardView.center = CGPoint(x: firstX, y: firstY)
        cardView.bounds = CGRect(x: 0, y: 0, width: bounds.width/2, height: bounds.height/2)
        parentView.addSubview(cardView)
        return cardView
    }
    
    func addNextCardView(to vc: CardViewController, gr: UIPanGestureRecognizer) -> UIView? {
        if let currentSelectedCellIndex = self.currentSelectedCellIndex?.row {
            if let nextCellIndexRow = self.viewModel.getNextCardIndex(currentCardIndex: currentSelectedCellIndex) {
                let cardView = self.createAndAddCardImageView(imageName: UIImage.init(named: self.viewModel.getImageName(at: nextCellIndexRow)), bounds: vc.cardImageView.bounds, parentView: vc.view)
                return cardView
            }
        }
        return nil
    }
    
    func addPreviousCardView(to vc: CardViewController, gr: UIPanGestureRecognizer) -> UIView? {
        if let currentSelectedCellIndex = self.currentSelectedCellIndex?.row {
            if let nextCellIndexRow = self.viewModel.getPreviousCardIndex(currentCardIndex: currentSelectedCellIndex) {
                let cardView = self.createAndAddCardImageView(imageName: UIImage.init(named: self.viewModel.getImageName(at: nextCellIndexRow)), bounds: vc.cardImageView.bounds, parentView: vc.view)
                return cardView
            }
        }
        return nil
    }
    
    
    func setNewValues(to vc: CardViewController, nextCellIndexRow: Int, gr: UIGestureRecognizer) {
            vc.cardImageView.alpha = 0
            UIView.animate(withDuration: 0.3) {
                vc.cardImageView.alpha = 1
                vc.cardImageView.image = UIImage.init(named: self.viewModel.getImageName(at: nextCellIndexRow))
                vc.bottomLabel.text = self.viewModel.getBottomText(at: nextCellIndexRow)
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
