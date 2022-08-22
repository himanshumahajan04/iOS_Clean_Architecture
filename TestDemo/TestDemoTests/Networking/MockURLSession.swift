//
//  MockURLSession.swift
//  TestDemoTests
//
//  Created by Himanshu Mahajan on 19/08/22.
//

import Foundation

class MockURLSession: URLSession {
    
    typealias completionHandler = (Data?, URLResponse?, Error?) -> Void

    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?
    
    override func dataTask(with request: URLRequest,
                           completionHandler: @escaping completionHandler) -> URLSessionDataTask {
        
        return MockURLSessionDataTask.init {
            completionHandler(self.data, self.urlResponse, self.error)
        }
    }
}
