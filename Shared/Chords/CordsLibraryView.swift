//
//  CordsLibraryView.swift
//  GuitarUkulele
//
//  Created by Aung Ko Min on 15/3/22.
//

import SwiftUI

struct CordsLibraryView: View {
    @State private var selectedInstrument: Instrument = .guitar
    @State private var selectedKey: String = "C"
    @State private var selectedSuffix: String = "major"
    
    private let instruments = [Instrument.guitar, Instrument.ukulele]
    private var foundChords: [Chord.Position] {
        selectedInstrument.findChordPositions(key: selectedKey, suffix: selectedSuffix)
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Image("logo")
                    .resizable()
                    .frame(width: 60, height: 60)
                
                Text("Fretboard")
                    .font(.largeTitle)
                    .padding()
                
                HStack {
                    Spacer()
                    Picker("Instrument", selection: $selectedInstrument) {
                        ForEach(instruments, id: \.self) {
                            Text($0.name.capitalized(with: nil))
                        }
                    }
                    Spacer()
                    Picker("Key", selection: $selectedKey) {
                        ForEach(selectedInstrument.keys, id: \.self) {
                            Text($0)
                        }
                    }
                    Spacer()
                    Picker("Suffix", selection: $selectedSuffix) {
                        ForEach(selectedInstrument.suffixes, id: \.self) {
                            Text($0)
                        }
                    }
                    Spacer()
                }
                
                
                HStack {
                    ForEach(foundChords, id: \.self) { position in
                        FretboardView(position: position)
                            .aspectRatio(0.6, contentMode: .fit)
                    }
                }
                
                Spacer()
            }
        }
        .padding()
    }
}
