//
//  NotificationsView.swift
//  ReelsPractice
//
//  Created by Michael Ma on 2024/5/14.
//

import SwiftUI

struct NotificationsView: View {
    
    @StateObject var viewModel = NotificationViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.notifications) { notification in
                        NotificationCell(notification: notification)
                    }
                }
            }
            .navigationTitle("Notification")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top)
            .onAppear {
                viewModel.fetchNotifications()
            }
        }
    }
}
