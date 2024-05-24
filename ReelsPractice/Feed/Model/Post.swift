//
//  Post.swift
//  ReelsPractice
//
//  Created by Michael Ma on 2024/5/14.
//

import Foundation

struct Post: Identifiable {
    var id: String = UUID().uuidString
    let video: VideoModel
    
    let likes: Int
    let comments: Int
}

extension Post: Decodable {}

struct VideoModel: Decodable {
    
    let urlString: String
    let title: String
    let desc: String
    
    enum CodingKeys: String, CodingKey {
        case urlString
        case title
        case desc = "description"
    }
}
