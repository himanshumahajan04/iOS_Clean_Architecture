//
//  MockPostService.swift
//  TestDemoTests
//
//  Created by Himanshu Mahajan on 19/08/22.
//

import Foundation
@testable import TestDemo

class MockPostService: IPostService {

    var response: [PostDataListDTO]?
    var error: Error?
    
    func fetchPostsFromNetwork(completion: @escaping (Result<[PostDataListDTO], Error>) -> Void) {
        if let error = error {
            return completion(.failure(error))
        }
        if let response = response {
            return completion(.success(response))
        }
    }
}
