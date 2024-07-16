//
//  RoverViewModel.swift
//  MarsDiscovery
//
//  Created by  Liza Kotova on 12.07.2024.
//

import Foundation

struct RoverViewModel: Identifiable {
    let id = UUID().uuidString
    let rover: String
    let camera: String
    let date: String
    let image: String
}
