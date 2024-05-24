//
//  ExploreViewModel.swift
//  ReelsPractice
//
//  Created by Michael Ma on 2024/5/20.
//

import Combine

final class ExploreViewModel: ObservableObject {
    
    var navigationTitle: String {
        "Explore"
    }
    
    @Published var friends: [Friend] = []
    
    func fetchFriends() {
        var result = [Friend]()
        for i in 1...10 {
            result.append(Friend(avatarUrlString: nil, name: "Test user 0\(i)", intro: "This is user 0\(i). Nice to meet you."))
        }
        self.friends = result
    }
}
