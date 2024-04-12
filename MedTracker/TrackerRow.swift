//
//  TrackerRow.swift
//  MedTracker
//
//  Created by Ravi on 2024-03-05.
//

import SwiftUI

struct TrackerRow: View {
    @State var store: MedTrackerStore
    var medTracker: MedTracker
    var body: some View {
        HStack{
            Image(uiImage: medTracker.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .frame(width: 75, height: 75)
            VStack(alignment: .leading) {
                Text(NSLocalizedString(medTracker.name, comment: ""))
                    .frame(width: 200, alignment: .leading)
                    .font(.largeTitle)
                Text("\(String(medTracker.dosagesLeft)) Dosages")
                Spacer()
                Text(NSLocalizedString(medTracker.type, comment: ""))
                Spacer()
                Text(NSLocalizedString(medTracker.description, comment: ""))
            }
            Spacer()
            NavigationLink(destination: EditTracker(store: store, medTracker: medTracker)) {
                
            }
        }
        .frame(height: 100)
    }
}

struct TrackerRow_Preview: PreviewProvider {
    
    static var store: MedTrackerStore = MedTrackerStore(medTrackers: [])
    
    static var previews: some View {
        TrackerRow(store: store, medTracker: MedTrackerStore.testTrackersStore.medTrackers[0])
    }
}
