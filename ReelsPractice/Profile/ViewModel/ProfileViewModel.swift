//
//  ProfileViewModel.swift
//  ReelsPractice
//
//  Created by Michael Ma on 2024/5/20.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    
    var navigationTitle: String {
        "Profile"
    }
    
    @Published var user: User = User(name: "Visitor", avatarUrlString: nil)
    
    func fetchUser() {
        DispatchQueue.global().async { [weak self] in
            self?.user = User(name: "User", avatarUrlString: "TestAvatar")
        }
    }
}
