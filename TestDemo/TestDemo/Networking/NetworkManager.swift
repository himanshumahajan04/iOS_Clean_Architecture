//
//  NetworkManager.swift
//  TestDemo
//
//  Created by Himanshu Mahajan on 14/08/22.
//

import Foundation

typealias Response<T: Decodable> = (Result<T, Error>) -> Void

protocol INetworkManager {
    func request<T: Decodable>(fromUrl url: URL, completion: @escaping Response<T>)
}

class NetworkManager: INetworkManager {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(fromUrl url: URL, completion: @escaping Response<T>) {
        
        let completionOnMain: Response<T> = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            if let _ = error {
                completionOnMain(.failure(NetworkError.badRequest))
            }
            
            guard let urlResponse = response as? HTTPURLResponse else { return completionOnMain(.failure(NetworkError.noResponse)) }
            if !(200...300).contains(urlResponse.statusCode) { return completionOnMain(.failure(NetworkError.failed)) }
            guard let data = data else {
                return completionOnMain(.failure(NetworkError.noData))
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completionOnMain(.success(decodedData))
            } catch {
                completionOnMain(.failure(NetworkError.unableToDecode))
            }
        }
        task.resume()
    }
}

