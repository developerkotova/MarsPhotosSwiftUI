//
//  MarsDiscoveryApp.swift
//  MarsDiscovery
//
//  Created by  Liza Kotova on 12.07.2024.
//

import SwiftUI

@main
struct MarsDiscoveryApp: App {
    @State private var showLoaderView = true
    
    var body: some Scene {
        WindowGroup {
            if showLoaderView {
                LoaderView(changeRootView: { showLoaderView = false })
                    .transition(.slide)
            } else {
                NavigationView {
                    HomeView()
                        .transition(.slide)
                }
            }
        }
    }
}
