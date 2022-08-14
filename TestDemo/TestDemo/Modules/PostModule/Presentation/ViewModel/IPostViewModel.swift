//
//  IPostViewModel.swift
//  TestDemo
//
//  Created by Himanshu Mahajan on 14/08/22.
//

import Foundation

// MARK: PostViewModel Protocol

protocol IPostViewModel {
    var posts: [PostCellViewModel] { get set }
    func fetchPosts()
    var outputDelegate: PostViewModelOutput? { get set }
}

// MARK: PostViewModelOutput Protocol

protocol PostViewModelOutput {
    func handleSuccess()
    func handleFailure(_ message: String)
}
