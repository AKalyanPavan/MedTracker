//
//  MyTrackersViewController.swift
//  MedTracker
//
//  Created by Ravi on 2024-02-13.
//

import UIKit

class MyTrackersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func gobackToHome(_ sender: Any) {
        let homePageStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = homePageStoryBoard.instantiateViewController(withIdentifier: "ViewControllerHome") as! ViewController
        viewController.navigationItem.hidesBackButton = true
        self.navigationController!.pushViewController(viewController, animated: true)
    }

}
