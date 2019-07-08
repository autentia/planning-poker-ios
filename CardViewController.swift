//
//  CardViewController.swift
//  AutentiaScrumCards
//
//  Created by Anton Zuev on 28/01/2019.
//

import UIKit

class CardViewController: UIViewController {

    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var bottomLabel: UILabel!
    
    var cardImage: UIImage?
    var bottomText: String?
    var delegate: CardViewSwipeProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardImageView.image = cardImage
        bottomLabel.text = bottomText
        titleLabel.text = "Your choice".localized
        closeButton.setTitle("Close".localized, for: UIControl.State.normal)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureHappened(_:)))
        self.view.addGestureRecognizer(panGestureRecognizer)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func panGestureHappened(_ sender: UIPanGestureRecognizer) {
        self.delegate?.panGestureHappened(vc: self, gr: sender)
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
