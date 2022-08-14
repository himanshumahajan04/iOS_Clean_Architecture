//
//  IPostRepository.swift
//  TestDemo
//
//  Created by Himanshu Mahajan on 14/08/22.
//

import Foundation

typealias DataResponse = (Result<[PostDomainListDTO], Error>) -> Void

protocol IPostRepository {
    func fetchPostList(completion: @escaping DataResponse)
}
