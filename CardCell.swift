//
//  CardCell.swift
//  AutentiaScrumCards
//
//  Created by Anton Zuev on 25/01/2019.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    var delegate: CardCellPressedProtocol?
    
    @IBOutlet weak var cardCellButton: UIButton!
    
    @IBAction func cardCellButtonPressed(_ sender: Any) {
        self.delegate?.cardCellPressed(cell: self)
    }
}
