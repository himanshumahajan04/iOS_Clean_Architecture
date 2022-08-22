//
//  MockData.swift
//  TestDemoTests
//
//  Created by Himanshu Mahajan on 17/08/22.
//

import Foundation

@testable import TestDemo

class MockData {
    
    static var posts: [PostDataListDTO] {
        try! JSONDecoder().decode([PostDataListDTO].self, from: postsData)
    }
    
    static var domainPosts: [PostDomainListDTO] {
        return posts.map { $0.toDmoain() }
    }
    
    static var postList: [Post] {
        return domainPosts.map { $0.toPresentation() }
    }
    
    static var postsData: Data {
        loadJsonData("Posts")
    }
    
    static func loadJsonData(_ fromFile: String) -> Data {
        let path = Bundle(for: self).path(forResource: fromFile, ofType: "json")
        let jsonString = try! String(contentsOfFile: path!, encoding: .utf8)
        let data = jsonString.data(using: .utf8)!
        return data
    }
}
