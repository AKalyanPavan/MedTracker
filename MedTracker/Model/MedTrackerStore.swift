//
//  MedTrackerStore.swift
//  MedTracker
//
//  Created by Ravi on 2024-03-05.
//

import Foundation
import Observation

@Observable
final class MedTrackerStore: ObservableObject {
    var medTrackers: [MedTracker]
    
    init(medTrackers: [MedTracker]) {
        self.medTrackers = medTrackers
    }
}

extension MedTrackerStore {
    static var mockData = [
        MedTracker(name: "Chrocine", type: "Syrup", dosagesLeft: 23, description: "Sample"),
//        MedTracker(name: "", type: "", dosagesLeft: 0, description: ""),
    ]
    
    static var testTrackersStore: MedTrackerStore = MedTrackerStore(medTrackers: mockData)
}

