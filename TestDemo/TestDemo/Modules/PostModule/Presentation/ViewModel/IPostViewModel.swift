//
//  IPostViewModel.swift
//  TestDemo
//
//  Created by Himanshu Mahajan on 14/08/22.
//

import Foundation

protocol IPostViewModel {
    var posts: [PostCellViewModel] { get set }
    func fetchPosts()
    var outputDelegate: PostViewModelOutput? { get set }
}

protocol PostViewModelOutput: AnyObject {
    func handleSuccess()
    func handleFailure(_ message: String)
}
