//
//  MyTrackersViewController.swift
//  MedTracker
//
//  Created by Ravi on 2024-02-13.
//

import UIKit

class MyTrackersViewController: UIViewController {
    
    @IBOutlet weak var dosageTextField: UITextField!
    @IBOutlet weak var frequencySegmentedControl: UISegmentedControl!
    @IBOutlet weak var dateTimeTextField: UITextField!
    
    let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDatePicker()
    }
    
    @IBAction func gobackToHome(_ sender: Any) {
        let homePageStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = homePageStoryBoard.instantiateViewController(withIdentifier: "ViewControllerHome") as! ViewController
        viewController.navigationItem.hidesBackButton = true
        self.navigationController!.pushViewController(viewController, animated: true)
    }
    
    func setupDatePicker() {
        // Set up date picker mode
        datePicker.datePickerMode = .dateAndTime

        // Add target to handle date picker value changes
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)

        // Set date picker as input view for dateTimeTextField
        dateTimeTextField.inputView = datePicker

        // Add a toolbar with a "Done" button to dismiss the date picker
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: false)

        dateTimeTextField.inputAccessoryView = toolbar
    }

    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        // Update the date and time in the text field as the user selects a new value
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short

        dateTimeTextField.text = dateFormatter.string(from: sender.date)
    }

    @objc func doneButtonTapped() {
        // Dismiss the date picker when the user taps "Done"
        dateTimeTextField.resignFirstResponder()
    }

    @IBAction func saveDosageButtonTapped(_ sender: UIButton) {
        // Handle saving the dosage information based on user input
        let dosage = dosageTextField.text ?? ""
        let frequencyIndex = frequencySegmentedControl.selectedSegmentIndex
        let dateTime = datePicker.date

        // Perform the necessary actions with the dosage, frequency, and dateTime values
        print("Dosage: \(dosage), Frequency Index: \(frequencyIndex), DateTime: \(dateTime)")
    }
}
