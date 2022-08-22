//
//  URLRequestGeneratorTests.swift
//  TestDemoTests
//
//  Created by Himanshu Mahajan on 20/08/22.
//

import XCTest

@testable import TestDemo

class URLRequestGeneratorTests: XCTestCase {
    
    var requestGenerator: IURLRequestGenerator!
    
    override func setUp() {
        super.setUp()
        requestGenerator = URLRequestGenerator()
    }
    
    override func tearDown() {
        requestGenerator = nil
        super.tearDown()
    }
    
    func testURLRequest() {
        let request = NetworkRequest(path: "/posts",
                                     method: .get,
                                     headerParamaters: ["Content-Type":"application/json"])
        do {
            let urlRequest = try requestGenerator.createURLRequest(using: request)
            XCTAssertEqual(urlRequest.url?.host, "jsonplaceholder.typicode.com")
            XCTAssertEqual(urlRequest.url?.scheme, "https")
            XCTAssertEqual(urlRequest.url?.path, "/posts")
            XCTAssertEqual(urlRequest.url, URL(string: "https://jsonplaceholder.typicode.com/posts?"))
            XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
            XCTAssertEqual(urlRequest.allHTTPHeaderFields, ["Content-Type":"application/json"])
            XCTAssertNil(urlRequest.httpBody)
        } catch (_) {
            XCTFail("Request Failure not expected")
        }
    }
}
