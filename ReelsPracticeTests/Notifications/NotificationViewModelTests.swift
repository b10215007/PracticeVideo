//
//  NotificationViewModelTests.swift
//  ReelsPracticeTests
//
//  Created by Michael Ma on 2024/5/20.
//

import XCTest
@testable import ReelsPractice

final class NotificationViewModelTests: XCTestCase {
    
    private var dateProvider: MockDateProvider!
    private var sut: NotificationViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        dateProvider = MockDateProvider()
        sut = NotificationViewModel(dateProvider: dateProvider)
    }
    
    override func tearDownWithError() throws {
        dateProvider = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func testInit() {
        XCTAssertTrue(sut.notifications.isEmpty)
    }
    
    func testFetchNotifications() {
        // Given:
        XCTAssertTrue(sut.notifications.isEmpty)
        dateProvider.date = Date()
        dateProvider.formatDateString = "test date string"
        
        // When:
        sut.fetchNotifications()
        
        // Then:
        XCTAssertEqual(sut.notifications.count, 10)
        XCTAssertEqual(sut.notifications[3].date, "test date string")
    }
}

private class MockDateProvider: DateProviding, DateFormatting {
    
    var date: Date!
    func getLatestDate() -> Date {
        date
    }
    
    var formatDateString: String = ""
    func format(_ date: Date) -> String {
        formatDateString
    }
}
