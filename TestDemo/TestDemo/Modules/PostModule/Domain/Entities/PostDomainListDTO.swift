//
//  PostDomainListDTO.swift
//  TestDemo
//
//  Created by Himanshu Mahajan on 14/08/22.
//

import Foundation

struct PostDomainListDTO: Equatable {
    let userId: Int
    let postId: Int
    let title: String
    let body: String
}

extension PostDomainListDTO {
    
    func toPresentation() -> Post {
        return .init(
            userId: userId,
            postId: postId,
            title: title,
            body: body)
    }
}
