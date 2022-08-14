//
//  PostRepositoryImpl.swift
//  TestDemo
//
//  Created by Himanshu Mahajan on 14/08/22.
//

import Foundation

class PostRepositoryImpl: IPostRepository {
        
    private let service: IPostService
    
    init(service: IPostService) {
        self.service = service
    }
    
    func fetchPostList(completion: @escaping DataResponse) {
        self.service.fetchPostsFromNetwork {
            (result: Result<[PostDataListDTO], Error>) in
                switch result {
                case .success(let posts):
                    completion(.success(posts.map { $0.toDmoain() }))
                case .failure(_):
                    completion(.failure(NetworkError.failed))
                }
        }
    }
}
