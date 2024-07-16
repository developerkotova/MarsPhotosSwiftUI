//
//  HomeModel.swift
//  MarsDiscovery
//
//  Created by  Liza Kotova on 12.07.2024.
//

import Foundation

struct RoverItem: Hashable, Identifiable {
    let id: String 
    let rover: String
    let camera: String
    let date: String
    let image: String
}
