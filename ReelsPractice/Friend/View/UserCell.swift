//
//  UserCell.swift
//  ReelsPractice
//
//  Created by Michael Ma on 2024/5/14.
//

import SwiftUI

struct UserCell: View {
    
    var user: Friend
    
    var body: some View {
        HStack(spacing: 12) {
            avatarImageView()
            
            VStack(alignment: .leading) {
                Text(user.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(user.intro)
                    .font(.footnote)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
    
    func avatarImageView() -> some View {
        
        if let avatarUrlString = user.avatarUrlString {
            return Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 48, height: 48)
                .foregroundColor(Color(.systemGray5))
        } else {
            return Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 48, height: 48)
                .foregroundColor(Color(.systemGray5))
        }
    }
}

#Preview {
    UserCell(user: Friend(
        avatarUrlString: nil,
        name: "Michael",
        intro: "This is michael, welcome to my place"))
}
