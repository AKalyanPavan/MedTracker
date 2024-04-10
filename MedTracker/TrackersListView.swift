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
    @State var showAlert = false;
    
    
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
            .navigationTitle(Text("My Trackers"))
            .searchable(text: $viewModel.searchTerm, placement: .navigationBarDrawer(displayMode: .automatic), prompt: Text("Search for Trackers"))
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
                    Button(action: {
                        showAlert = true
                    }) {
                        Text("Delete All")
                    }
                    .alert(isPresented: $showAlert){
                        Alert(
                            title: Text("Delete All Trackers"),
                            message: Text("Are you sure you want to delete all trackers? This action cannot be undone."),
                            primaryButton: .destructive(Text("Delete")) {
                                withAnimation {
                                    viewModel.deleteAllTracker()
                                }
                            },
                            secondaryButton: .cancel(Text("Cancel"))
                        )
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
