//
//  ViewController.swift
//  MedTracker
//
//  Created by Ravi on 2024-01-23.
//

import UIKit

class ViewController: UIViewController {
    
    var medTrackers: [MedTracker] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func gotoCreateTracker(_ sender: Any) {
        let createNewStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let createNewViewController = createNewStoryBoard.instantiateViewController(withIdentifier: "CreateNewTrackerViewController") as! CreateNewTrackerViewController
        createNewViewController.navigationItem.hidesBackButton = true
        createNewViewController.medTrackers = medTrackers
        self.navigationController!.pushViewController(createNewViewController, animated: true)
    }
    @IBAction func gotoMyTrackers(_ sender: Any) {
        let myTrackersStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let myTrackersViewController = myTrackersStoryBoard.instantiateViewController(withIdentifier: "MyTrackersViewController") as! MyTrackersViewController
        myTrackersViewController.navigationItem.hidesBackButton = true
        self.navigationController!.pushViewController(myTrackersViewController, animated: true)
    }
    @IBAction func gotoPhysicians(_ sender: Any) {
        let physiciansStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let physiciansViewController = physiciansStoryBoard.instantiateViewController(withIdentifier: "PhysiciansViewController") as! PhysiciansViewController
        physiciansViewController.navigationItem.hidesBackButton = true
        self.navigationController!.pushViewController(physiciansViewController, animated: true)
    }
    
}

