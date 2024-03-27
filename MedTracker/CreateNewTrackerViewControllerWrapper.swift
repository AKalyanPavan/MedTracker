//
//  CreateNewTrackerViewControllerWrapper.swift
//  MedTracker
//
//  Created by Tahmid Hassan on 2024-03-25.
//

import Foundation
import SwiftUI

struct CreateNewTrackerViewControllerWrapper: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some CreateNewTrackerViewController {
        return CreateNewTrackerViewController()
    }
}
