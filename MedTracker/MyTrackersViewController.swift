//
//  MyTrackersViewController.swift
//  MedTracker
//
//  Created by Ravi on 2024-02-13.
//

import UIKit

class MyTrackersViewController: UIViewController {

    var medicationTracks: [Medication] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let medication1 = Medication(name: "Ibuprofen", type: .painRelief)
        let medication2 = Medication(name: "Amoxicillin", type: .antibiotics)
        let medication3 = Medication(name: "Vitamin C", type: .vitamins)
        let medication4 = Medication(name: "Paracetamol", type: .painRelief)
        let medication5 = Medication(name: "Aspirin", type: .painRelief)
        let medication6 = Medication(name: "Cough Syrup", type: .syrup)
        let medication7 = Medication(name: "Calcium Supplement", type: .vitamins)
        let medication8 = Medication(name: "Antihistamine", type: .painRelief)
        let medication9 = Medication(name: "Penicillin", type: .antibiotics)
        let medication10 = Medication(name: "Vitamin D", type: .vitamins)
        let medication11 = Medication(name: "Cetirizine", type: .painRelief)
        let medication12 = Medication(name: "Codeine", type: .painRelief)
        let medication13 = Medication(name: "Fish Oil", type: .vitamins)
        let medication14 = Medication(name: "Ibuprofen Cream", type: .painRelief)
        let medication15 = Medication(name: "Multivitamin", type: .vitamins)
        let medication16 = Medication(name: "Azithromycin", type: .antibiotics)
        let medication17 = Medication(name: "Cephalexin", type: .antibiotics)
        let medication18 = Medication(name: "Naproxen", type: .painRelief)
        let medication19 = Medication(name: "Diphenhydramine", type: .painRelief)
        let medication20 = Medication(name: "Zinc Supplement", type: .vitamins)
        
        medicationTracks.append(contentsOf: [medication1, medication2, medication3, medication4, medication5,
                                             medication6, medication7, medication8, medication9, medication10,
                                             medication11, medication12, medication13, medication14, medication15,
                                             medication16, medication17, medication18, medication19, medication20])
    }
    
    @IBOutlet weak var medicationTypeSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var medicationListView: UIStackView!
    
    @IBAction func gobackToHome(_ sender: Any) {
        let homePageStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = homePageStoryBoard.instantiateViewController(withIdentifier: "ViewControllerHome") as! ViewController
        viewController.navigationItem.hidesBackButton = true
        self.navigationController!.pushViewController(viewController, animated: true)
    }
    
    func filterTracks(by type: MedicationType) -> [Medication] {
        return medicationTracks.filter { $0.type == type }
    }
    
    func updateUI(with filteredTracks: [Medication]) {
        // Clear previous UI elements
        for view in medicationListView.arrangedSubviews {
            medicationListView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        // Add new UI elements for filtered tracks
        for track in filteredTracks {
            let nameLabel = UILabel()
            nameLabel.text = track.name
            medicationListView.addArrangedSubview(nameLabel)
        }
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        guard let type = MedicationType(rawValue: selectedIndex) else {
            return
        }
        let filteredTracks = filterTracks(by: type)
        updateUI(with: filteredTracks)
    }

}
