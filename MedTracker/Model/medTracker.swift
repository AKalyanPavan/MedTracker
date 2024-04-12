//
//  medTracker.swift
//  MedTracker
//
//  Created by Ravi on 2024-03-05.
//

import Foundation
import UIKit

struct MedTracker: Identifiable {
    var id: UUID
    var name: String
    var type: String
    var dosagesLeft: Int
    var description: String
    var image: UIImage
    
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
