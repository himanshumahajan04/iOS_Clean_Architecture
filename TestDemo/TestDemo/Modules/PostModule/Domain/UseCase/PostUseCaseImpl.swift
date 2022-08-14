//
//  PostUseCase.swift
//  TestDemo
//
//  Created by Himanshu Mahajan on 14/08/22.
//

import Foundation

class PostUseCaseImpl: IPostUseCase {
        
    private let respository: IPostRepository
    
    init(respository: IPostRepository) {
        self.respository = respository
    }
    
    func fetchPostList(completion: @escaping DomainResponse) {
        return self.respository.fetchPostList { (result: Result<[PostDomainListDTO], Error>) in
            switch result {
            case .success(let posts):
                completion(.success(posts.map { $0.toPresentation() } ))
            case .failure(_):
                completion(.failure(NetworkError.failed))
            }
        }
    }
}
