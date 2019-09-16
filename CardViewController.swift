//
//  CardViewController.swift
//  AutentiaScrumCards
//
//  Created by Anton Zuev on 28/01/2019.
//

import UIKit
import AudioToolbox

class CardViewController: UIViewController {

    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var bottomLabel: UILabel!
    
    var cardImage: UIImage?
    var bottomText: String?
    var delegate: CardViewChangeProtocol?
    
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
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            self.delegate?.shakeGestureHappened(vc: self)
            self.makeVibrations()
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    func makeVibrations() {
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
    }

}
