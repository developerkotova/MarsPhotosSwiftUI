//
//  RoverPhotoRequestModel.swift
//  MarsDiscovery
//
//  Created by  Liza Kotova on 12.07.2024.
//

import Foundation

struct RoverPhoto: Codable {
    let photos: [Photos]
}

struct Photos: Codable {
    let id: Int
    let sol: Int
    let camera: Camera
    let imgSrc: String
    let earthDate: String
    let rover: Rover
    
    enum CodingKeys: String, CodingKey {
        case id, sol, camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
}

struct Camera: Codable {
    let id: Int
    let name: String
    let roverID: Int
    let fullName: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case roverID = "rover_id"
        case fullName = "full_name"
    }
}

struct Rover: Codable {
    let id: Int
    let name: String
    let landingDate: String
    let launchDate: String
    let status: String
    let maxSol: Int
    let maxDate: String
    let totalPhotos: Int
    let cameras: [RoverCamera]
    
    enum CodingKeys: String, CodingKey {
        case id, name, status
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case maxSol = "max_sol"
        case maxDate = "max_date"
        case totalPhotos = "total_photos"
        case cameras
    }
}
struct RoverCamera: Codable {
    let name: String
    let fullName: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
    }
}

enum Rovers: String, CaseIterable {
    case curiosity
    case opportunity
    case spirit
    
    var fullName: String {
        switch self {
        case .curiosity:
            return "Curiosity"
        case .opportunity:
            return "Opportunity"
        case .spirit:
            return "Spirit"
        }
    }
    
    static func from(fullName: String) -> Rovers? {
        return Rovers.allCases.first { $0.fullName == fullName }
    }
    
    static var allRawValues: [String] {
        return Rovers.allCases.map { $0.fullName }
    }
}

enum Cameras: String, CaseIterable {
    case fhaz
    case rhaz
    case mast
    case chemcam
    case mahli
    case mardi
    case navcam
    case pancam
    case minites
    
    
    var fullName: String {
        switch self {
        case .fhaz:
            return "Front Hazard Avoidance Camera"
        case .rhaz:
            return "Rear Hazard Avoidance Camera"
        case .mast:
            return "Mast Camera"
        case .chemcam:
            return "Chemistry and Camera Complex"
        case .mahli:
            return "Mars Hand Lens Imager"
        case .mardi:
            return "Mars Descent Imager"
        case .navcam:
            return "Navigation Camera"
        case .pancam:
            return "Panoramic Camera"
        case .minites:
            return "Miniature Thermal Emission Spectromete"
        }
    }
    
    static func from(fullName: String) -> Cameras? {
        return Cameras.allCases.first { $0.fullName == fullName }
    }
    
    static var allRawValues: [String] {
        return Cameras.allCases.map { $0.fullName }
    }
}

