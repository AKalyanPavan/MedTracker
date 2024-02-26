//
//  CreateNewTrackerViewController.swift
//  MedTracker
//
//  Created by Ravi on 2024-02-13.
//

import SwiftUI
import UIKit
import Foundation

class CreateNewTrackerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var dosageScheduleView: UIStackView!
    
    @IBOutlet weak var nameOfTrackerText: UITextField!
    @IBOutlet weak var typeOfMedicineText: UITextField!
    @IBOutlet weak var dosagesLeft: UITextField!
    
    let options = ["Tablet", "Syrup", "Capsule", "Injection", "Powder", "Inhaler", "Drops"]
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create UILabels
        let label1 = UILabel()
        label1.text = "Label 1"

        let label2 = UILabel()
        label2.text = "Label 2"

        let label3 = UILabel()
        label3.text = "Label 3"

        // Add the UILabels to the stack view
        dosageScheduleView.addArrangedSubview(label1)
        dosageScheduleView.addArrangedSubview(label2)
        dosageScheduleView.addArrangedSubview(label3)

        // Customize stack view properties
        dosageScheduleView.axis = .vertical
        dosageScheduleView.alignment = .center
        dosageScheduleView.distribution = .fillEqually
        dosageScheduleView.spacing = 8
        
        nameOfTrackerText.layer.borderColor = UIColor.systemGreen.cgColor
        nameOfTrackerText.layer.borderWidth = 1
        nameOfTrackerText.layer.cornerRadius = 5
        
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
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        
        let options = ["Tablet", "Syrup", "Capsule", "Injection", "Powder", "Inhaler", "Drops"]
        let newLabel = UITextField()
        
        let newPicker = UIPickerView()
        newPicker.delegate = self
        newPicker.dataSource = self
        
        func newPicker(_ newPicker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return options.count
        }
        
        func newPicker(_ newPicker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return options[row]
        }

        func newPicker(_ newPicker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            newLabel.text = options[row]
        }

        newLabel.inputView = newPicker
        
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: false)
    
        dosageScheduleView.addArrangedSubview(newLabel)
        
        innerView.frame.size.height = innerView.bounds.height + 28.0

        // Refresh the layout
        dosageScheduleView.layoutIfNeeded()
    }
    
    @IBAction func gobackToHome(_ sender: Any) {
        let homePageStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = homePageStoryBoard.instantiateViewController(withIdentifier: "ViewControllerHome") as! ViewController
        viewController.navigationItem.hidesBackButton = true
        self.navigationController!.pushViewController(viewController, animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeOfMedicineText.text = options[row]
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
