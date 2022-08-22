//
//  PostUseCaseTests.swift
//  TestDemoTests
//
//  Created by Himanshu Mahajan on 20/08/22.
//

import XCTest

@testable import TestDemo

class PostUseCaseTests: XCTestCase {
    
    var postUseCase: IPostUseCase!
    var mockPostRepository: MockPostRepository!
    
    override func setUp() {
        super.setUp()
        mockPostRepository = MockPostRepository()
        postUseCase = PostUseCaseImpl(respository: mockPostRepository)
    }
    
    override func tearDown() {
        postUseCase = nil
        mockPostRepository = nil
        super.tearDown()
    }
    
    func testPostUseCaseSuccess() {
        let expeectation = expectation(description: "PostUseCase Success Case")
        mockPostRepository.posts = MockData.domainPosts
        
        postUseCase.fetchPostList { (result: Result<[Post], Error>) in
            switch result {
            case let .success(posts):
                XCTAssertTrue(posts.count == 4)
                expeectation.fulfill()
            case .failure(_):
                XCTFail("Failure not expected")
            }
        }
        wait(for: [expeectation], timeout: 2.0)
    }
    
    func testPostUseCaseFailure() {
        let expectation = expectation(description: "PostUseCase Failure Case")
        mockPostRepository.error = NSError(domain: "Failed_Error", code: 0)
        
        postUseCase.fetchPostList { (result: Result<[Post], Error>) in
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
