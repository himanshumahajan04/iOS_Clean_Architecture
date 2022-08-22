//
//  URLRequestGenerator.swift
//  TestDemo
//
//  Created by Himanshu Mahajan on 17/08/22.
//

import Foundation

protocol IURLRequestGenerator {
    func createURLRequest(using endPoint: INetworkRequest) throws -> URLRequest
}

class URLRequestGenerator: IURLRequestGenerator {
        
    func createURLRequest(using endPoint: INetworkRequest) throws -> URLRequest {
        do {
            let url = try createURL(with: endPoint)
            
            var urlRequest = URLRequest(url: url,
                                        cachePolicy: .useProtocolCachePolicy,
                                        timeoutInterval: 10.0)
    
            urlRequest.httpMethod = endPoint.method.rawValue
            
            if !endPoint.bodyParamaters.isEmpty {
                let bodyData = try? JSONSerialization.data(withJSONObject: endPoint.bodyParamaters, options: [.prettyPrinted])
                urlRequest.httpBody = bodyData
            }
            
            endPoint.headerParamaters.forEach({ key, value in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            })
            
            return urlRequest
        } catch {
            throw error
        }
    }
    
    private func createURL(with endPoint: INetworkRequest) throws -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Configuration.host
        components.path = endPoint.path
        components.queryItems = endPoint.queryParameters.map {
            URLQueryItem(name: $0, value: "\($1)")
        }
        
        guard let url = components.url else {
            throw NSError(domain: "URL", code: NSURLErrorBadURL, userInfo: nil)
        }
        return url
    }
}
