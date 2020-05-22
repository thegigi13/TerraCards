//
//  APIProvider.swift
//  TerraCards
//
//  Created by foxy on 21/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import Foundation
import UIKit




enum APIResponse {
    case image(image: UIImage)
    case data(data: Data)
    case cardList(cardList: CardList)
}

enum APIError: Error {
    case noResponse
    
    case networkError(error: Error)
    case serverError(response: URLResponse?)
        
    case dataIsNotAnImage
    case notAPathToAnImage
    case dataCantBeDecoded
    
    case unknown
}



struct APIProvider {
    typealias Completion = (Result<APIResponse, APIError>) -> Void

    typealias APIResult = (Result<APIResponse, APIError>)
    
    static let shared = APIProvider()
    
    
    private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30 // seconds
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration)
    }()
    
    
}

extension APIProvider {
    public func downloadImageFromURL(url: URL, completion: @escaping Completion) {
        APIProvider.shared.session.dataTask(with: url, completionHandler: {data, response, error in
            guard
                APIProvider.shared.handleHttpError(data: data, response: response, error: error, errorCompletion: completion) == nil,
                let image = APIProvider.shared.handleImage(data: data, response: response, error: error, errorCompletion: completion)
                else {
                    print("échec de chargement de l'image")
                    return
            }
            DispatchQueue.main.async() {
                print("image chargée")
                completion(.success(.image(image: image)))
            }
        } ).resume()
        
    }
    
    
    public func requestAllRecords(completion: @escaping Completion) {
        let url = URL(string: "https://api.airtable.com/v0/appPrjpqmbTjrOAI9/Card")!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let params = ["api_key":"keyXSumLVSJRFmMRd"]
        components?.queryItems = params.map({URLQueryItem(name: $0, value: $1)})
        var request = URLRequest(url: (components?.url!)!)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        let task = APIProvider.shared.session.dataTask(with: request) { data, response, error in
            guard
                self.handleHttpError(data: data, response: response, error: error, errorCompletion: completion) == nil,
                let data = self.handleData(data: data, response: response, error: error, errorCompletion: completion) else {
                    print("erreur lors de la récupération des données de Airtable")
                    return
            }
            completion(.success(.data(data: data)))
        }
        task.resume()
    }
    
    
    
}


extension APIProvider {
    func handleHttpError(data: Data?, response: URLResponse?, error: Error?, errorCompletion completion: @escaping Completion) -> Error? {
        
        guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200 else {
            completion(.failure(.noResponse))
            return APIError.serverError(response: response)
        }
        guard error == nil else {
            completion(.failure(.noResponse))
            return APIError.networkError(error: error!)
        }
        // pas d'erreur
        return nil
    }
    
    func handleData(data: Data?, response: URLResponse?, error: Error?, errorCompletion completion: @escaping Completion) -> Data? {
        
        guard let data = data else {
            completion(.failure(.noResponse))
            return nil
        }
        
        return data
    }
    
    func handleImage(data: Data?, response: URLResponse?, error: Error?, errorCompletion completion: @escaping Completion) -> UIImage? {
        
        guard let data = data else {
            completion(.failure(.noResponse))
            return nil
        }
        
        guard let image = UIImage(data: data) else {
            completion(.failure(.dataIsNotAnImage))
            return nil
        }
        
        guard let mimeType = response?.mimeType, mimeType.hasPrefix("image") else {
            completion(.failure(.notAPathToAnImage))
            return nil
        }
        
        return image
    }
    
    
    
}
