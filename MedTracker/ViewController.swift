//
//  ViewController.swift
//  MedTracker
//
//  Created by Ravi on 2024-01-23.
//

import UIKit
import SwiftUI
import UserNotifications

class ViewController: UIViewController {
    
    var medTrackers: [MedTracker] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
        
        scheduleNotification()
    }
    
    @IBAction func gotoCreateTracker(_ sender: Any) {
        let createNewStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let createNewViewController = createNewStoryBoard.instantiateViewController(withIdentifier: "CreateNewTrackerViewController") as! CreateNewTrackerViewController
        createNewViewController.navigationItem.hidesBackButton = true
        createNewViewController.medTrackers = medTrackers
        self.navigationController!.pushViewController(createNewViewController, animated: true)
    }
    @IBAction func gotoMyTrackers(_ sender: Any) {
        //        let myTrackersStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        //        let myTrackersViewController = myTrackersStoryBoard.instantiateViewController(withIdentifier: "MyTrackersViewController") as! MyTrackersViewController
        //        myTrackersViewController.navigationItem.hidesBackButton = true
        //        self.navigationController!.pushViewController(myTrackersViewController, animated: true)
        
        let trackersListView = TrackersListView(viewModel: TrackersListViewModel())
        let hostingController = UIHostingController(rootView: trackersListView)
        navigationController?.pushViewController(hostingController, animated: true)
    }
    @IBAction func gotoPhysicians(_ sender: Any) {
        let physiciansStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let physiciansViewController = physiciansStoryBoard.instantiateViewController(withIdentifier: "PhysiciansViewController") as! PhysiciansViewController
        physiciansViewController.navigationItem.hidesBackButton = true
        self.navigationController!.pushViewController(physiciansViewController, animated: true)
    }
   
    func scheduleNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Don't forget to take your medicine!"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        
        let request = UNNotificationRequest(identifier: "MedicineReminder", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
}

