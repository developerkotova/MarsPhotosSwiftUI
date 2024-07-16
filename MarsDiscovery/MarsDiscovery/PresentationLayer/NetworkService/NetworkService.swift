//
//  NetworkService.swift
//  MarsDiscovery
//
//  Created by  Liza Kotova on 12.07.2024.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol: AnyObject {
    func fetchPhotos(
        from rover: Rovers,
        camera: Cameras?,
        and date: String,
        with page: Int,
        completion: @escaping (Result<[Photos], Error>) -> Void
    )
}

final class NetworkService: NetworkServiceProtocol {
    private let api_key = "ewxzH5G3hwoFZV3HroZGlgm6GdnFWy6mVIERMVe4"
    
    func fetchPhotos(
        from rover: Rovers = .curiosity,
        camera: Cameras? = nil,
        and date: String,
        with page: Int = 1,
        completion: @escaping (Result<[Photos], Error>) -> Void
    ) {
        var url = "https://api.nasa.gov/mars-photos/api/v1/rovers/\(rover)/photos?earth_date=\(date)&api_key=\(api_key)&page=\(page)"
        if let camera = camera {
            url.append("&camera=\(camera)")
        }
        
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let data = try JSONDecoder().decode(RoverPhoto.self, from: data)
                    completion(.success(data.photos))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

