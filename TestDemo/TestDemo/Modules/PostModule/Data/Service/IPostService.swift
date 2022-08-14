//
//  IPostService.swift
//  TestDemo
//
//  Created by Himanshu Mahajan on 14/08/22.
//

import Foundation

protocol IPostService {
    func fetchPostsFromNetwork(completion: @escaping (Result<[PostDataListDTO], Error>) -> Void)
}
