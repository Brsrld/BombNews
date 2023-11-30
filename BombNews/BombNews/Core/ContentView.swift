//
//  ContentView.swift
//  BombNews
//
//  Created by Barış Şaraldı on 30.11.2023.
//

import SwiftUI

struct ContentView: View {
    let service: HomeServiceable = HomeService()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
