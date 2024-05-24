//
//  NotificationViewModel.swift
//  ReelsPractice
//
//  Created by Michael Ma on 2024/5/20.
//

import Combine

typealias DateProviderProtocol = DateProviding & DateFormatting

final class NotificationViewModel: ObservableObject {
    @Published var notifications: [Notification] = []
    
    private let dateProvider: DateProviderProtocol
    init(dateProvider: DateProviderProtocol = DateProvider()) {
        self.dateProvider = dateProvider
    }
    
    func fetchNotifications() {
        var result = [Notification]()
        for i in 1...10 {
            let length = Int.random(in: 10...120)
            let desc = randomString(length: length)
            let date = dateProvider.getLatestDate()
            let dateString = dateProvider.format(date)
            result.append(Notification(
                userAvatarUrlString: nil,
                title: "This is notification title",
                desc: desc,
                date: dateString))
        }
        self.notifications = result
    }
}

extension NotificationViewModel: RandomStringProviding {}
