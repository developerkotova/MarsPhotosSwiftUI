//
//  HomeViewModel.swift
//  MarsDiscovery
//
//  Created by  Liza Kotova on 12.07.2024.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    private let networkService: NetworkServiceProtocol
    
    private var rovers = [RoverItem]()
    private var filteredRovers = [RoverItem]()
    
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    
    func fetchPhotos(
        from rover: Rovers,
        camera: Cameras?,
        and date: String,
        with page: Int,
        completion: @escaping ([RoverItem]?, Error?) -> ()
    ) {
        networkService.fetchPhotos(
            from: rover,
            camera: camera,
            and: date,
            with: page
        ) { [weak self] result in
            guard let self = self else {return}
            self.rovers = []
            switch result {
            case .success(let photos):
                photos.forEach { photo in
                    let convertedDate = photo.earthDate.toDate()
                    let item = RoverItem(
                        id: "\(photo.id)", 
                        rover: "Rover: \(photo.rover.name)",
                        camera: "Camera: \(photo.camera.fullName)",
                        date: "Date: \(convertedDate.toString(format: .long))",
                        image: photo.imgSrc
                    )
                    self.rovers.append(item)
                }
                filteredRovers = rovers
                completion(filteredRovers, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    
}
