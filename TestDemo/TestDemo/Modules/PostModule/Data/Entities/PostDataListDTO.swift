//
//  PostDataListDTO.swift
//  TestDemo
//
//  Created by Himanshu Mahajan on 14/08/22.
//

import Foundation

struct PostDataListDTO: Decodable {
    let userId: Int
    let postId: Int
    let title: String
    let body: String

    private enum CodingKeys: String, CodingKey {
        case userId
        case postId = "id"
        case title
        case body
    }
}

extension PostDataListDTO {

    func toDmoain() -> PostDomainListDTO {
        return .init(
            userId: userId,
            postId: postId,
            title: title,
            body: body)
    }
}
