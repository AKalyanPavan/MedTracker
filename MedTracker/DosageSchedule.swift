//
//  DosageSchedule.swift
//  MedTracker
//
//  Created by Ravi on 2024-02-24.
//

import UIKit

class DosageSchedule: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let label1 = UILabel()
        label1.text = "Label 1"

        let label2 = UILabel()
        label2.text = "Label 2"

        let label3 = UILabel()
        label3.text = "Label 3"

        let stackView = UIStackView(arrangedSubviews: [label1, label2, label3])

        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 50) 
        ])
    }
}
