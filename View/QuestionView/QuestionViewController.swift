//
//  QuestionViewController.swift
//  AutentiaScrumCards
//
//  Created by Anton Zuev on 29/01/2019.
//

import UIKit

class QuestionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
            if let vc = segue.destination as? MainViewController{
                if (segue.identifier == "shirtSizes"){
                    vc.viewModel = CardsViewModel(cards: shirtSizes)
                }
                else if(segue.identifier == "fibonacci"){
                    vc.viewModel = CardsViewModel(cards: numericCards)
                }
            }
    }

}
