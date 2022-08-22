//
//  NetworkRequest.swift
//  TestDemo
//
//  Created by Himanshu Mahajan on 17/08/22.
//

import Foundation

enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

protocol INetworkRequest {
    var path: String { get set }
    var method: HTTPMethod { get set }
    var headerParamaters: [String: String] { get set }
    var queryParameters: [String: Any] { get set }
    var bodyParamaters: [String: Any] { get set }
}

class NetworkRequest: INetworkRequest {
    
    var path: String
    var method: HTTPMethod
    var headerParamaters: [String: String]
    var queryParameters: [String: Any]
    var bodyParamaters: [String: Any]
   
    init(path: String,
         method: HTTPMethod,
         headerParamaters: [String: String] = [:],
         queryParameters: [String: Any] = [:],
         bodyParamaters: [String: Any] = [:]) {
        self.path = path
        self.method = method
        self.headerParamaters = headerParamaters
        self.queryParameters = queryParameters
        self.bodyParamaters = bodyParamaters
    }
}
