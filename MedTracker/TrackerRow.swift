//
//  TrackerRow.swift
//  MedTracker
//
//  Created by Ravi on 2024-03-05.
//

import SwiftUI

struct TrackerRow: View {
    var medTracker: MedTracker
    var body: some View {
        HStack{
            Image(uiImage: medTracker.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .frame(width: 75, height: 75)
            VStack(alignment: .leading) {
                Text(medTracker.name)
                    .font(.largeTitle)
                Text("\(String(medTracker.dosagesLeft)) Dosages")
                Spacer()
                Text(medTracker.type)
                Spacer()
                Text(medTracker.description)
            }
            .frame(height: 100)
        }
    }
}

struct TrackerRow_Preview: PreviewProvider {
    static var previews: some View {
        TrackerRow(medTracker: MedTrackerStore.testTrackersStore.medTrackers[0])
    }
}
