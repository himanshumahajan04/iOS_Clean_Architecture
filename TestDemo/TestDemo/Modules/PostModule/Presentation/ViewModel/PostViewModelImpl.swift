//
//  PostViewModel.swift
//  TestDemo
//
//  Created by Himanshu Mahajan on 14/08/22.
//

import Foundation

class PostViewModelImpl: IPostViewModel {
        
    var outputDelegate: PostViewModelOutput?
    var posts: [PostCellViewModel] = [PostCellViewModel]()
        
    private let useCase: IPostUseCase
        
    init(useCase: IPostUseCase) {
        self.useCase = useCase
    }
        
    func fetchPosts() {
        
        self.useCase.fetchPostList { result in
            switch result {
            case let .success(posts):
                self.posts = self.processFetchedPosts(posts)
                self.outputDelegate?.handleSuccess()
            case let .failure(error):
                self.outputDelegate?.handleFailure(error.localizedDescription)
            }
        }
    }
    
    // MARK: Methods
    
    private func processFetchedPosts(_ posts: [Post]) -> [PostCellViewModel] {
        var postCellViewModel = [PostCellViewModel]()
        for post in posts {
            let cellViewModel = PostCellViewModel(post.title, post.body)
            postCellViewModel.append(cellViewModel)
        }
        return postCellViewModel
    }
}
