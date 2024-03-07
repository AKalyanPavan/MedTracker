//
//  MyTrackersViewController.swift
//  MedTracker
//
//  Created by Ravi on 2024-02-13.
//

import UIKit
import SwiftUI

class MyTrackersViewController: UIViewController {
    
    var medTrackers: [MedTracker] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    @IBAction func gobackToHome(_ sender: Any) {
        let homePageStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = homePageStoryBoard.instantiateViewController(withIdentifier: "ViewControllerHome") as! ViewController
        viewController.navigationItem.hidesBackButton = true
        viewController.medTrackers = medTrackers
        self.navigationController!.pushViewController(viewController, animated: true)
    }
}
