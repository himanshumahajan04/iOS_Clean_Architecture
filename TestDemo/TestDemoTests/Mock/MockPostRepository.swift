//
//  MockPostRepository.swift
//  TestDemoTests
//
//  Created by Himanshu Mahajan on 20/08/22.
//

import XCTest

@testable import TestDemo

class MockPostRepository: IPostRepository {
    
    var posts: [PostDomainListDTO]?
    var error: Error?
    
    func fetchPostList(completion: @escaping DataResponse) {
        if let error = error {
            return completion(.failure(error))
        }
        if let posts = posts {
            return completion(.success(posts))
        }
    }
}
