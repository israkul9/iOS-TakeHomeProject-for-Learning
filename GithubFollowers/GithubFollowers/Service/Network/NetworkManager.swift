//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Tusher on 1/22/24.
//


import Alamofire
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    private init(){
    }
    
    // A set to store Combine cancellables for later cleanup
    private var cancellables: Set<AnyCancellable> = []

    // Function to make a network request for a single model using Combine
    func request<T: Decodable>(
        baseUrl: String,
        path: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        modelType: T.Type
    ) -> AnyPublisher<T, Error> {
        // Construct the full URL by combining the base URL and path
        let url = baseUrl + path

        // Create a Combine Future that performs the network request
        return Future<T, Error> { promise in
            // Use Alamofire to make the network request
            AF.request(url,
                       method: method,
                       parameters: parameters)
                .validate()
                .responseDecodable(of: T.self) { response in
                    // Handle the result of the network request
                    switch response.result {
                    case .success(let value):
                        // If the request is successful, fulfill the promise with the decoded value
                        promise(.success(value))
                    case .failure(let error):
                        // If the request fails, handle different types of errors based on status codes
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 401:
                                promise(.failure(NetworkError.unauthorized))
                            case 403:
                                promise(.failure(NetworkError.forbidden))
                            case 404:
                                promise(.failure(NetworkError.notFound))
                            case 500...599:
                                promise(.failure(NetworkError.serverError(statusCode)))
                            default:
                                promise(.failure(error))
                            }
                        } else {
                            promise(.failure(error))
                        }
                    }
                }
        }
        // Ensure the completion is received on the main thread
        .receive(on: DispatchQueue.main)
        // Erase the type for better composability
        .eraseToAnyPublisher()
    }

    // Function to make a network request for an array of models using Combine
    func requestArray<T: Decodable>(
        baseUrl: String,
        path: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        modelType: [T].Type
    ) -> AnyPublisher<[T], Error> {
        // Construct the full URL by combining the base URL and path
        let url = baseUrl + path

        // Create a Combine Future that performs the network request
        return Future<[T], Error> { promise in
            // Use Alamofire to make the network request
            AF.request(url,
                       method: method,
                       parameters: parameters)
                .validate()
                .responseDecodable(of: [T].self) { response in
                    // Handle the result of the network request
                    switch response.result {
                    case .success(let value):
                        // If the request is successful, fulfill the promise with the decoded value
                        promise(.success(value))
                    case .failure(let error):
                        // If the request fails, handle different types of errors based on status codes
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 401:
                                promise(.failure(NetworkError.unauthorized))
                            case 403:
                                promise(.failure(NetworkError.forbidden))
                            case 404:
                                promise(.failure(NetworkError.notFound))
                            case 500...599:
                                promise(.failure(NetworkError.serverError(statusCode)))
                            default:
                                promise(.failure(error))
                            }
                        } else {
                            promise(.failure(error))
                        }
                    }
                }
        }
        // Ensure the completion is received on the main thread
        .receive(on: DispatchQueue.main)
        // Erase the type for better composability
        .eraseToAnyPublisher()
    }
}

// Enum for custom network errors
enum NetworkError: Error {
    case unauthorized
    case forbidden
    case notFound
    case serverError(Int)
}
