//
//  ContentView.swift
//  Shared
//
//  Created by Aung Ko Min on 15/3/22.
//

import SwiftUI

import SwiftUI
enum ContentType: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    case ChordsLibrary, Tuner
}
struct ContentView: View {
    
    @State private var selectedInstrument: Instrument = .guitar
    @State private var selectedKey: String = "C"
    @State private var selectedSuffix: String = "major"
    @State private var contentType = ContentType.ChordsLibrary
    
    private let instruments = [Instrument.guitar, Instrument.ukulele]
    private var foundChords: [Chord.Position] {
        selectedInstrument.findChordPositions(key: selectedKey, suffix: selectedSuffix)
    }
    
    var body: some View {
        TabView {
            CordsLibraryView()
                .tabItem {
                    Label("Chord Library", systemImage: "applelogo")
                }
            TunerView()
                .tabItem {
                Label("Tuner", systemImage: "applelogo")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

