//
//  Notification.swift
//  ReelsPractice
//
//  Created by Michael Ma on 2024/5/20.
//

import Foundation

struct Notification: Identifiable {
    var id: String = UUID().uuidString
    
    let userAvatarUrlString: String?
    let title: String
    let desc: String
    let date: String
}

extension Notification: Decodable {}
