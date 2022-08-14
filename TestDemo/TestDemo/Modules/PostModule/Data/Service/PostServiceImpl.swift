//
//  PostServiceImpl.swift
//  TestDemo
//
//  Created by Himanshu Mahajan on 14/08/22.
//

import Foundation

class PostServiceImpl: IPostService {
        
    private let networkManager: INetworkManager
    
    init(networkManager: INetworkManager) {
        self.networkManager = networkManager
    }

    func fetchPostsFromNetwork(completion: @escaping (Result<[PostDataListDTO], Error>) -> Void) {
        guard let postsURL = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        self.networkManager.request(fromUrl: postsURL, completion: completion)
    }
}
