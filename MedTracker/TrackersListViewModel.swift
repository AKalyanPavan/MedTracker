//
//  TrackersListViewModel.swift
//  MedTracker
//
//  Created by Ravi on 2024-03-05.
//

import Foundation
import SwiftUI
import Observation

@Observable
final class TrackersListViewModel: ObservableObject {
    
    var store: MedTrackerStore
    var navTitle: String = ""
    var searchTerm: String = ""
    var searchResults: [MedTracker] = []
    
    var listData: [MedTracker] {
        return searchTerm.isEmpty ? store.medTrackers : searchResults
    }
    
    init(store: MedTrackerStore = MedTrackerStore.testTrackersStore, navTitle: String = "My Trackers") {
        self.store = store
        self.navTitle = navTitle
    }
    
    var displayCount: String {
        "\(listData.count) Trackers"
    }
    
    func filterSearchResults(){
        searchResults = store.medTrackers.filter({
            $0.name.localizedStandardContains(searchTerm)
        })
    }
    
    func deleteTracker(offset: IndexSet){
        store.medTrackers.remove(atOffsets: offset)
    }
    
    func moveTracker(from: IndexSet, to:Int){
        store.medTrackers.move(fromOffsets: from, toOffset: to)
    }
    
    func deleteAllTracker(){
        store.medTrackers.removeAll()
    }
}
