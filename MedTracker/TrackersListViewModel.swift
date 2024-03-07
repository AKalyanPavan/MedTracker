//
//  TrackersListViewModel.swift
//  MedTracker
//
//  Created by Ravi on 2024-03-05.
//

import Foundation
import SwiftUI

final class TrackersListViewModel: ObservableObject {
    
    @ObservedObject var store: MedTrackerStore
    @Published var navTitle: String = ""
    @Published var searchTerm: String = ""
    @Published var searchResults: [MedTracker] = []
    
    var listData: [MedTracker] {
        return searchTerm.isEmpty ? store.medTrackers : searchResults
    }
    
    init(store: MedTrackerStore = MedTrackerStore.testTrackersStore, navTitle: String = "My Trackers") {
        self.store = store
        self.navTitle = navTitle
    }
}
