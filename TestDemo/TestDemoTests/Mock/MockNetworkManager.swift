//
//  MockNetworkManager.swift
//  TestDemoTests
//
//  Created by Himanshu Mahajan on 18/08/22.
//

import Foundation
@testable import TestDemo

class MockNetworkManager: INetworkManager {

    var response: Decodable?
    var error: Error?
    
    func request<T: Decodable>(request: INetworkRequest, completion: @escaping Response<T>) {
        if let error = error {
            return completion(.failure(error))
        }
        if let resposne = response {
            completion(.success(resposne as! T))
        }
    }
}
