//
//  PostViewModelTests.swift
//  TestDemoTests
//
//  Created by Himanshu Mahajan on 20/08/22.
//

import XCTest

@testable import TestDemo

class PostViewModelTests: XCTestCase {
    
    var viewModel: IPostViewModel!
    var mockPostUseCase: MockPostUseCase!
    var delegate: MockPostViewModelOutput!
     
    override func setUp() {
        super.setUp()
        mockPostUseCase = MockPostUseCase()
        delegate = MockPostViewModelOutput()
        viewModel = PostViewModelImpl(useCase: mockPostUseCase)
        viewModel.outputDelegate = delegate
    }
    
    override func tearDown() {
        viewModel = nil
        mockPostUseCase = nil
        delegate = nil
        super.tearDown()
    }
    
    func testSuccessScenario() {
        mockPostUseCase.posts = MockData.postList
        viewModel.fetchPosts()
        
        XCTAssertTrue(viewModel.posts.count == 4)
        XCTAssert(delegate.methodsCalled.contains("handleSuccess()"))
    }

    func testErrorScenario() {
        mockPostUseCase.error = NSError(domain: "Failed_Error", code: 0)
        viewModel.fetchPosts()
        
        XCTAssertTrue(viewModel.posts.count == 0)
        XCTAssert(delegate.methodsCalled.contains("handleFailure(_:)"))
    }
}

class MockPostViewModelOutput: PostViewModelOutput  {

    var methodsCalled = [String]()

    func handleSuccess() {
        methodsCalled.append(#function)
    }
    
    func handleFailure(_ message: String) {
        methodsCalled.append(#function)
    }
}
