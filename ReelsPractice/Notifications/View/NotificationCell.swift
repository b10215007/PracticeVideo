//
//  NotificationCell.swift
//  ReelsPractice
//
//  Created by Michael Ma on 2024/5/14.
//

import SwiftUI

struct NotificationCell: View {
    
    var notification: Notification
    
    var body: some View {
        HStack {
            avatarImageView()
            
            /// Use + to concate Text view
            HStack {
                Text(notification.title)
                    .font(.footnote)
                    .fontWeight(.semibold) +
                
                Text("  ") +
                
                Text(notification.desc)
                    .font(.footnote) +
                
                Text("  ") +
                
                Text(notification.date)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            thumbnailView()
        }
        .padding(.horizontal)
    }
    
    func avatarImageView() -> some View {
        
        if let avatarUrlString = notification.userAvatarUrlString {
            return Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundStyle(Color(.systemGray5))
        } else {
            return Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundStyle(Color(.systemGray5))
        }
    }
    
    func thumbnailView() -> some View {
        Rectangle()
            .frame(width: 48, height: 48)
            .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

#Preview {
    NotificationCell(notification: Notification(
        userAvatarUrlString: nil,
        title: "Title",
        desc: "Today is a great day liked one of your posts. Have a nice day",
        date: "3 days"))
}
