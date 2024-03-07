//
//  TrackersListView.swift
//  MedTracker
//
//  Created by Ravi on 2024-03-05.
//

import Foundation
import SwiftUI

struct TrackersListView: View {
    @ObservedObject var viewModel: TrackersListViewModel
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.listData) { tracker in
                    TrackerRow(medTracker: tracker)
                }
            }
        }
    }
}

struct TrackersListView_Previews: PreviewProvider {
    static var previews: some View {
        TrackersListView(viewModel: TrackersListViewModel())
    }
}
