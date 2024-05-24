//
//  DateProvider.swift
//  ReelsPractice
//
//  Created by Michael Ma on 2024/5/20.
//

import Foundation

final class DateProvider: DateProviding, DateFormatting {
    func getLatestDate() -> Date {
        Date()
    }
    
    func format(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        return formatter.string(from: date)
    }
}
