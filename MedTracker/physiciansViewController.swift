//
//  PhysiciansViewController.swift
//  MedTracker
//
//  Created by Ravi on 2024-02-13.
//

import UIKit

class PhysiciansViewController: UIViewController {

    @IBOutlet weak var thisistest: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
