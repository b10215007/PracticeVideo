//
//  File.swift
//  ReelsPractice
//
//  Created by Michael Ma on 2024/5/20.
//

import Foundation

struct Friend: Identifiable {
    var id: String = UUID().uuidString
    
    let avatarUrlString: String?
    let name: String
    let intro: String
}

extension Friend: Decodable {}
