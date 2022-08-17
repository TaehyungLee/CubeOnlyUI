//
//  ContentView.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/08/17.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        NavigationView {
            ZStack {
                VStack {
                    NavigationLink {
                        SettingView()
                    } label: {
                        Text("Setting")
                    }
                    .padding()
                    NavigationLink {
                        SearchView()
                    } label: {
                        Text("Search")
                    }
                    .padding()
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(.automatic)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
