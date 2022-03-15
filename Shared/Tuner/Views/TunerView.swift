//
//  TunerView.swift
//  BmTuner
//
//  Created by Aung Ko Min on 8/6/21.
//
import SwiftUI

struct TunerView: View {
    @ObservedObject private var tunerController = TunerController()
    @AppStorage("modifierPreference") private var modifierPreference = ModifierPreference.preferSharps
    @AppStorage("selectedTransposition") private var selectedTransposition = 0

    private var tunerData: TunerData { tunerController.data }

    var body: some View {
        ScrollView(showsIndicators: false) {
            HStack {
                TranspositionMenu(selectedTransposition: $selectedTransposition)
                Spacer()
            }.padding()
            Spacer()
            MatchedNoteView(
                match: tunerData.closestNote.inTransposition(ScaleNote.allCases[selectedTransposition]),
                modifierPreference: modifierPreference
            )
            .onTapGesture {
                modifierPreference = modifierPreference.toggled
            }

            MatchedNoteFrequency(frequency: tunerData.closestNote.frequency)

            NoteDistanceMarkers()
                .overlay(
                    CurrentNoteMarker(
                        frequency: tunerData.pitch,
                        distance: tunerData.closestNote.distance
                    )
                )
            Spacer()
            
        }
        .onAppear(perform: tunerController.start)
        .onDisappear(perform: tunerController.stop)
        .alert(isPresented: $tunerController.showMicrophoneAccessAlert) {
            Alert(
                title: Text("No microphone access"),
                message: Text(
                    """
                    Please grant microphone access in the Settings app in the "Privacy ⇾ Microphone" section.
                    """)
            )
        }
    }
}

struct TunerView_Previews: PreviewProvider {
    static var previews: some View {
        TunerView()
    }
}
