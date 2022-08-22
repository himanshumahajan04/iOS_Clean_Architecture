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
        let request = NetworkRequest(path: "/posts", method: .get)
        self.networkManager.request(request: request, completion: completion)
    }
}
