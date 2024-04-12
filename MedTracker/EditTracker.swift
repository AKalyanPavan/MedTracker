//
//  EditTracker.swift
//  MedTracker
//
//  Created by Ravi on 2024-03-25.
//

import SwiftUI

struct EditTracker: View {
    
    @State var store: MedTrackerStore
    @State var medTracker: MedTracker
    @State private var trackerName = ""
    @Environment(\.presentationMode) var presentationMode
    let options = ["Tablet", "Syrup", "Capsule", "Injection", "Powder", "Inhaler", "Drops"]
    
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Text("Tracker Name")
                    TextField("Name", text: $medTracker.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
                HStack {
                    Text("Type of Medicine")
                    Picker("", selection: $medTracker.type) {
                                    ForEach(options, id: \.self) { option in
                                        Text(option)
                                    }
                                }
                }
                HStack {
                    Text("Dosages Left")
                    TextField("Dosages", value: $medTracker.dosagesLeft, format: .number)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
                HStack {
                    Text("Description")
                        .frame(alignment: .topLeading)
                    TextEditor(text: $medTracker.description)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(height: 200)
                        .padding()
                }
                HStack {
                    Spacer()
                    Button("Save", action: {
                        print(MedTrackerStore.testTrackersStore.medTrackers)
                        let index = MedTrackerStore.testTrackersStore.medTrackers.firstIndex(where: { $0.id == medTracker.id })
                        print(index as Any)
                        MedTrackerStore.testTrackersStore.medTrackers[index!] = medTracker
                        presentationMode.wrappedValue.dismiss()
                    })
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding()
                }
            }
            .navigationTitle("Edit Tracker")
        }
    }
}

//struct EditTracker_Preview: PreviewProvider {
//    static var previews: some View {
//        EditTracker(medTracker: MedTracker(name: "Chrocine", type: "Syrup", dosagesLeft: 23, description: "Sample"), store: store)
//    }
//}
