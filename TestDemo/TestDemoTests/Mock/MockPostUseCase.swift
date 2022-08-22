//
//  MockPostUseCase.swift
//  TestDemoTests
//
//  Created by Himanshu Mahajan on 20/08/22.
//

import XCTest

@testable import TestDemo

class MockPostUseCase: IPostUseCase {

    var posts: [Post]?
    var error: Error?
    
    func fetchPostList(completion: @escaping DomainResponse) {
        if let error = error {
            return completion(.failure(error))
        }
        if let posts = posts {
            return completion(.success(posts))
        }
    }
}
