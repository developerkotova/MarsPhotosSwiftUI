//
//  PickerFilterViewModel.swift
//  MarsDiscovery
//
//  Created by  Liza Kotova on 12.07.2024.
//
import Foundation

struct PickerFilterViewModel {
    let title: String
    let type: FilterType
    
    enum FilterType {
        case camera, rover
        
        var data: [String] {
            switch self {
            case .camera:
                return Cameras.allRawValues
            case .rover:
                return Rovers.allRawValues
            }
        }
    }
}
