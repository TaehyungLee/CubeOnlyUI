//
//  CubeOnlyUIApp.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/08/17.
//

import SwiftUI

@main
struct CubeOnlyUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(CommonViewModel())
        }
    }
}
