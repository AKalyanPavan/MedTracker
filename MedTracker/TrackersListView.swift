//
//  TrackersListView.swift
//  MedTracker
//
//  Created by Ravi on 2024-03-05.
//

import Foundation
import SwiftUI

struct TrackersListView: View {
    @State var viewModel: TrackersListViewModel
    @State var isAddingTracker = false;
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.listData) { tracker in
                    TrackerRow(medTracker: tracker)
                }
                .onMove(perform: viewModel.moveTracker)
                .onDelete(perform: viewModel.deleteTracker)
                
                
                HStack{
                    Spacer()
                    Text(viewModel.displayCount)
                        .foregroundStyle(.secondary)
                    Spacer()
                }
            }
            .navigationTitle(viewModel.navTitle)
            .searchable(text: $viewModel.searchTerm, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Search for Trackers")
            .onChange(of: viewModel.searchTerm) {
                viewModel.filterSearchResults()
            }
            .toolbar{
                HStack{
//                    Button("Add") {
//                        isAddingTracker = true
//                    }
                    EditButton()
                    Spacer()
                    Button("Delete All") {
                        withAnimation {
                            viewModel.deleteAllTracker()
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $isAddingTracker) {
                CreateNewTrackerViewControllerWrapper()
            }
        }
    }
}

struct TrackersListView_Previews: PreviewProvider {
    static var previews: some View {
        TrackersListView(viewModel: TrackersListViewModel())
    }
}
