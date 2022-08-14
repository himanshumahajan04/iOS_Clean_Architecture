//
//  IPostUseCase.swift
//  TestDemo
//
//  Created by Himanshu Mahajan on 14/08/22.
//

import Foundation

typealias DomainResponse = (Result<[Post], Error>) -> Void

protocol IPostUseCase {
    func fetchPostList(completion: @escaping DomainResponse)
}
