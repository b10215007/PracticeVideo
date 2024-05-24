//
//  DateFormatting.swift
//  ReelsPractice
//
//  Created by Michael Ma on 2024/5/20.
//

import Foundation

protocol DateProviding {
    func getLatestDate() -> Date
}

protocol DateFormatting {
    func format(_ date: Date) -> String
}
