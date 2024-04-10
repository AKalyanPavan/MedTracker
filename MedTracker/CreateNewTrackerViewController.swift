//
//  CreateNewTrackerViewController.swift
//  MedTracker
//
//  Created by Ravi on 2024-02-13.
//

import SwiftUI
import UIKit
import Foundation

class CreateNewTrackerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var innerView: UIView!
    
    @IBOutlet weak var descriptionText: UITextView!
    
    @IBOutlet weak var nameOfTrackerText: UITextField!
    @IBOutlet weak var typeOfMedicineText: UITextField!
    @IBOutlet weak var dosagesLeft: UITextField!
    
    @IBOutlet weak var createNewTrackerLabel: UILabel!
    @IBOutlet weak var trackerNameLabel: UILabel!
    @IBOutlet weak var typeOfMedicineLabel: UILabel!
    @IBOutlet weak var dosagesLeftLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var takePhotoBtn: UIButton!
    
    var medTrackers: [MedTracker] = []
    var medTrackerStore: MedTrackerStore = MedTrackerStore.testTrackersStore
    
    let options = ["Tablet", "Syrup", "Capsule", "Injection", "Powder", "Inhaler", "Drops"]
    var pickerView = UIPickerView()
    
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create UILabels
        let label1 = UILabel()
        label1.text = "Label 1"

        let label2 = UILabel()
        label2.text = "Label 2"

        let label3 = UILabel()
        label3.text = "Label 3"
        
        createNewTrackerLabel.text = NSLocalizedString("Create New Tracker", comment: "")
        trackerNameLabel.text = NSLocalizedString("Tracker Name", comment: "")
        typeOfMedicineLabel.text = NSLocalizedString("Type of Medicine", comment: "")
        dosagesLeftLabel.text = NSLocalizedString("Dosages Left", comment: "")
        descriptionLabel.text = NSLocalizedString("Description", comment: "")
        
        saveBtn.setTitle(NSLocalizedString("Take Photo", comment: ""), for: .normal)
        takePhotoBtn.setTitle(NSLocalizedString("Save", comment: ""), for: .normal)
        
        nameOfTrackerText.contentHorizontalAlignment = .left
        nameOfTrackerText.adjustsFontSizeToFitWidth = false
        
        nameOfTrackerText.layer.borderColor = UIColor.systemGreen.cgColor
        nameOfTrackerText.layer.borderWidth = 1
        nameOfTrackerText.layer.cornerRadius = 5
        
        typeOfMedicineText.layer.borderColor = UIColor.systemGreen.cgColor
        typeOfMedicineText.layer.borderWidth = 1
        typeOfMedicineText.layer.cornerRadius = 5
        
        dosagesLeft.layer.borderColor = UIColor.systemGreen.cgColor
        dosagesLeft.layer.borderWidth = 1
        dosagesLeft.layer.cornerRadius = 5
        
        descriptionText.layer.borderWidth = 1.0
        descriptionText.layer.borderColor = UIColor.systemGreen.cgColor
        descriptionText.layer.cornerRadius = 8.0
        
        dosagesLeft.delegate = self
        dosagesLeft.keyboardType = .numberPad
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        typeOfMedicineText.inputView = pickerView
        
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: false)

        typeOfMedicineText.inputAccessoryView = toolbar
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

        let startDate = dateFormatter.date(from: "2024-02-16 09:00")!

        let weeklySchedule = WeeklySchedule(schedule: [
            "Sunday": ["06:00", "10:00"],
            "Monday": ["21:00"]
        ])

        var myEvent = Event(title: "Team Meeting", startDate: startDate)
        myEvent.recurrence = Recurrence(frequency: "weekly", weeklySchedule: weeklySchedule, endCondition: .onDate(date: dateFormatter.date(from: "2024-04-21 22:00")!))

        // Calculate occurrences
        if let eventOccurrences = myEvent.calculateOccurrences() {
            print(eventOccurrences)
        } else {
            print("No occurrences found.")
        }
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveTracker(_ sender: Any) {
        
        let name = nameOfTrackerText.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if(checkForEmpty(trimmedText: name, nameOfField: "Tracker Name")){
            return
        }
        
        let type = typeOfMedicineText.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if(checkForEmpty(trimmedText: type, nameOfField: "Type of Medicine")){
            return
        }
        
        let dosagesRemaining = dosagesLeft.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if(checkForEmpty(trimmedText: dosagesRemaining, nameOfField: "Dosages Left")){
            return
        }
        
        let description = descriptionText.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if(checkForEmpty(trimmedText: description, nameOfField: "Description")){
            return
        }
        
        guard let image = selectedImage else {
            showAlert(message: "Please select an image!")
            return
        }
        
        let newMedTracker = MedTracker(name: name, type: type, dosagesLeft: Int(dosagesRemaining) ?? 0, description: description, image: selectedImage ?? UIImage(named: "medicine")!)
        medTrackers.append(newMedTracker)
        medTrackerStore.medTrackers.append(newMedTracker)
        
        selectedImage = nil
        
//        let myTrackersStoryBoard = UIStoryboard(name: "Main", bundle: nil)
//        let myTrackersViewController = myTrackersStoryBoard.instantiateViewController(withIdentifier: "MyTrackersViewController") as! MyTrackersViewController
//        myTrackersViewController.navigationItem.hidesBackButton = true
//        myTrackersViewController.medTrackers = medTrackers
//        self.navigationController!.pushViewController(myTrackersViewController, animated: true)
        
        nameOfTrackerText.text = ""
        dosagesLeft.text = ""
        descriptionText.text = ""
        typeOfMedicineText.text = ""
        
        let trackersListView = TrackersListView(viewModel: TrackersListViewModel())
                let hostingController = UIHostingController(rootView: trackersListView)
                present(hostingController, animated: true, completion: nil)
    }
    
    @IBAction func addPhoto(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    
    func checkForEmpty(trimmedText: String, nameOfField: String) -> Bool {
        if trimmedText.isEmpty {
            showAlert(message: "\(nameOfField) cannot be empty")
            return true
        } else {
            return false
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return NSLocalizedString(options[row], comment: "")
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeOfMedicineText.text = NSLocalizedString(options[row], comment: "")
    }
    
    @objc func doneButtonTapped() {
        typeOfMedicineText.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == dosagesLeft {
            let allowedCharacterSet = CharacterSet(charactersIn: "0123456789")
            let replacementStringCharacterSet = CharacterSet(charactersIn: string)
            return allowedCharacterSet.isSuperset(of: replacementStringCharacterSet)
        }

        return true
    }
    
}

struct WeeklySchedule {
    var schedule: [String: [String]]
}

struct Event {
    var title: String
    var startDate: Date
    var recurrence: Recurrence?
}

struct Recurrence {
    var frequency: String
    var weeklySchedule: WeeklySchedule
    var endCondition: EndCondition
}

enum EndCondition {
    case never
    case onDate(date: Date)
    case afterOccurrences(occurrences: Int)
}

extension Event {
    func calculateOccurrences() -> [Date]? {
        guard let recurrence = recurrence else {
            print("No recurrence is set for this event.")
            return nil
        }

        var occurrences: [Date] = []
        var currentDate = startDate
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "America/New_York")!
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.timeZone = TimeZone(identifier: "America/New_York")

        while true {
            let dayOfWeek = calendar.component(.weekday, from: currentDate)
            let weekdaySymbols = calendar.weekdaySymbols
            let weekdayString = weekdaySymbols[dayOfWeek - 1]

            let times = recurrence.weeklySchedule.schedule[weekdayString] ?? []

            for time in times {
                let components = time.components(separatedBy: ":")
                var dateComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
                dateComponents.hour = Int(components[0])
                dateComponents.minute = Int(components[1])

                if let occurrenceDate = calendar.date(from: dateComponents) {
                    let edtDate = formatter.string(from: occurrenceDate)
                    if let edtDate = formatter.date(from: edtDate) {
                        occurrences.append(edtDate)
                    }
                }
            }

            if case let .onDate(endDate) = recurrence.endCondition, currentDate >= endDate {
                break
            }

            if case let .afterOccurrences(occurrencesCount) = recurrence.endCondition, occurrences.count >= occurrencesCount {
                break
            }

            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }

        return occurrences
    }
}
