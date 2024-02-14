//
//  MedicationType.swift
//  MedTracker
//
//  Created by Tahmid Hassan on 2024-02-13.
//
import Foundation

enum MedicationType {
    case painRelief
    case antibiotics
    case vitamins
    case capsule
    case syrup
    
    init?(rawValue: Int) {
        switch rawValue {
        case 0: self = .capsule
        case 1: self = .syrup
        case 2: self = .painRelief
        case 3: self = .antibiotics
        case 4: self = .vitamins
           
        default: return nil
        }
    }
}
