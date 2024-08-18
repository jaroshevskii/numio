//
//  ContentView.swift
//  Numio
//
//  Created by Sasha Jaroshevskii on 18.08.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "timer")
                .symbolRenderingMode(.multicolor)
                .imageScale(.large)
            
            Text("Hello, Numio!")
                .fontWeight(.bold)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
