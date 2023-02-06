//
//  ContentView.swift
//  SpaceNews
//
//  Created by A Farhan Agustiansyah on 06/02/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var data = SpaceAPI()

    
    var body: some View {
        NavigationView {
            VStack {
                
            }
        }
        .navigationTitle("Space News")
        .environmentObject(data)
        .onAppear {
            data.getData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
