//
//  medTracker.swift
//  MedTracker
//
//  Created by Ravi on 2024-03-05.
//

import Foundation
import UIKit

struct MedTracker: Identifiable {
    let id: UUID
    let name: String
    let type: String
    let dosagesLeft: Int
    let description: String
    let image: UIImage
    
    /// Computed properties
    var imageName: String { name }
    var thumbnailName: String { return name + "Thumb" }
    
    internal init(id: UUID = UUID(), name: String, type: String, dosagesLeft: Int, description: String, image: UIImage) {
        self.id = id
        self.name = name
        self.type = type
        self.dosagesLeft = dosagesLeft
        self.description = description
        self.image = image
    }
}
