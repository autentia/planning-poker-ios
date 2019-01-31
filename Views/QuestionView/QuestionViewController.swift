//
//  QuestionViewController.swift
//  AutentiaScrumCards
//
//  Created by Anton Zuev on 29/01/2019.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var shirtSizesButton: UIButton!
    @IBOutlet weak var fibonacciButton: UIButton!
    
    var mainFrame: MainFrameProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.questionLabel.text = "EstimationQuestion".localized
        self.shirtSizesButton.setTitle("ShirtSizes".localized, for: UIControl.State.normal)
        self.fibonacciButton.setTitle("Fibonacci".localized, for: UIControl.State.normal)
        mainFrame = MainFrame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let navigationBar = self.navigationController?.navigationBar
        //remove one pixel line in the navigation bar
        navigationBar?.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        navigationBar?.shadowImage = UIImage()
        //customize navigation item
        self.navigationItem.title = "Title".localized
        self.navigationItem.backBarButtonItem?.title = "Menu".localized
        self.navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Montserrat-SemiBold", size: 18)!], for: UIControl.State.normal)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = false  //Show
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        mainFrame.showCardsViewController(for: segue)
    }

}
