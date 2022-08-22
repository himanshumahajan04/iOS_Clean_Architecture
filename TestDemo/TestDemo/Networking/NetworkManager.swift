//
//  NetworkManager.swift
//  TestDemo
//
//  Created by Himanshu Mahajan on 14/08/22.
//

import Foundation

typealias Response<T: Decodable> = (Result<T, Error>) -> Void

protocol INetworkManager {
    func request<T: Decodable>(request: INetworkRequest, completion: @escaping Response<T>)
}

class NetworkManager: INetworkManager {
    
    private let session: URLSession
    private let requestGenerator: IURLRequestGenerator
    
    init(session: URLSession, requestGenerator: IURLRequestGenerator) {
        self.session = session
        self.requestGenerator = requestGenerator
    }
    
    convenience init(session: URLSession = .shared) {
        self.init(session: session, requestGenerator: URLRequestGenerator())
    }
    
    func request<T: Decodable>(request: INetworkRequest, completion: @escaping Response<T>) {
        
        guard let urlRequest = try? requestGenerator.createURLRequest(using: request) else {
            return completion(.failure(NetworkError.invalidRequest))
        }

        let task = session.dataTask(with: urlRequest) { data, response, error in

            if let _ = error {
                return completion(.failure(NetworkError.badRequest))
            }
            
            guard let urlResponse = response as? HTTPURLResponse else {
                return completion(.failure(NetworkError.noResponse))
            }
            
            if urlResponse.statusCode != 200 {
                return completion(.failure(NetworkError.failed))
            }
            
            guard let data = data else {
                return completion(.failure(NetworkError.noData))
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(NetworkError.unableToDecode))
            }
        }
        task.resume()
    }
}
