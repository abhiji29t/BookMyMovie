//
//  NetworkService.swift
//  BookMyMovie
//
//  Created by Abhijitkumar A on 25/03/20.
//  Copyright © 2020 Abhijitkumar A. All rights reserved.
//

import Foundation

// Enum to define all types of errror occured during fetching of data
enum NetworkError: Error {
    case clientError
    case serverError
    case noData
    case dataDecodingError
}

class NetworkService {

    static let shared = NetworkService()

    // Method to fetch data from the server, decode into generic type and handling the completion block
    func makeUrlRequest<T: Decodable>(_ request: URLRequest, _ isJSON: Bool, resultHandler: @escaping (Result<T, NetworkError>) -> Void) {
        let urlTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                resultHandler(.failure(.clientError))
                return
            }

            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                resultHandler(.failure(.serverError))
                return
            }

            guard let safeData = data else {
                resultHandler(.failure(.noData))
                return
            }

            if isJSON {
                do {
                    let decoder = JSONDecoder()
                    let results = try decoder.decode(T.self, from: safeData)
                    resultHandler(.success(results))
                } catch {
                    resultHandler(.failure(.dataDecodingError))
                }
            } else {
                if let imageData = safeData as? T {
                    resultHandler(.success(imageData))
                }
            }
        }
        urlTask.resume()
    }
}

