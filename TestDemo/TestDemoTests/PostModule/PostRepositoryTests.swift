//
//  PostRepositoryTests.swift
//  TestDemoTests
//
//  Created by Himanshu Mahajan on 19/08/22.
//

import XCTest

@testable import TestDemo

class PostRepositoryTest: XCTestCase {
    
    var postRepository: IPostRepository!
    var mockPostService: MockPostService!
    
    override func setUp() {
        super.setUp()
        mockPostService = MockPostService()
        postRepository = PostRepositoryImpl(service: mockPostService)
    }
    
    override func tearDown() {
        postRepository = nil
        mockPostService = nil
        super.tearDown()
    }

    func testPostRepository_Success() {
        let expectation = expectation(description: "Post Repository of Success Case")
        mockPostService.response = MockData.posts
        
        mockPostService.fetchPostsFromNetwork { (result: Result<[PostDataListDTO], Error>) in
            switch result {
            case let .success(response):
                if response.count > 0 {
                    expectation.fulfill()
                }
            case .failure(_):
                XCTFail("Failure not expected")
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testPostRepository_Failure() {
        let expectation = expectation(description: "Post Repositoy of Failure Case")
        mockPostService.error = NetworkError.failed

        mockPostService.fetchPostsFromNetwork { (result: Result<[PostDataListDTO], Error>) in
            switch result {
            case .success(_):
                XCTFail("Success not expected")
            case let .failure(error):
                XCTAssertEqual(error as! NetworkError, NetworkError.failed)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
}
