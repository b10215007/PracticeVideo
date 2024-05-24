//
//  User.swift
//  ReelsPractice
//
//  Created by Michael Ma on 2024/5/20.
//

import Foundation

struct User {
    let name: String
    let avatarUrlString: String?
}

extension User: Decodable {}
