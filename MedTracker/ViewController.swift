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
    let languageSetting = LanguageSetting()
    
    @IBOutlet weak var mytrackerbtn: UIButton!
    @IBOutlet weak var createNewTrackerBtn: UIButton!
    @IBOutlet weak var physiciansNearbyBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ThemeManager.applyTheme()
        
        mytrackerbtn.setTitle(NSLocalizedString("My Trackers", comment: ""), for: .normal)
        createNewTrackerBtn.setTitle(NSLocalizedString("Create New Tracker", comment: ""), for: .normal)
        physiciansNearbyBtn.setTitle(NSLocalizedString("Physicians Nearby", comment: ""), for: .normal)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(didTapSettings))
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
        
        scheduleNotification()
    }
    
    @objc private func didTapSettings(){
        let settingsView = SettingsView()
        let settingsHostingController = UIHostingController(rootView: settingsView)
        self.navigationController?.pushViewController(settingsHostingController, animated: true)
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
        
        let trackersListView = TrackersListView(viewModel: TrackersListViewModel(), store: MedTrackerStore(medTrackers: []))
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
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 600, repeats: true)
        
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

