//
//  PostServiceImplTests.swift
//  TestDemoTests
//
//  Created by Himanshu Mahajan on 18/08/22.
//

import XCTest

@testable import TestDemo

class PostServiceTests: XCTestCase {

    var postService: IPostService!
    var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        postService = PostServiceImpl(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        postService = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    func testPostService_Success() {
        let expectation = expectation(description: "Post Service on Success Case")
        mockNetworkManager.response = MockData.posts
        postService.fetchPostsFromNetwork { (result: Result<[PostDataListDTO], Error>) in
            switch result {
            case let .success(posts):
                if posts.count > 0 {
                    expectation.fulfill()
                }
            case .failure(_):
                XCTFail("Failure not expected")
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }

    func testPostService_Failure() {
        let expectation = expectation(description: "Post Service on Failure Case")
        mockNetworkManager.error = NSError(domain: "FailedError", code: 0)
        postService.fetchPostsFromNetwork { (result: Result<[PostDataListDTO], Error>) in
            switch result {
            case .success(_):
                XCTFail("Success not expected")
            case .failure(_):
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
}
