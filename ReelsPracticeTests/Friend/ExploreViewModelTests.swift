//
//  ExploreViewModelTests.swift
//  ReelsPracticeTests
//
//  Created by Michael Ma on 2024/5/20.
//

import XCTest
@testable import ReelsPractice

final class ExploreViewModelTests: XCTestCase {
    
    private var sut: ExploreViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ExploreViewModel()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testInit() {
        XCTAssertTrue(sut.friends.isEmpty)
    }
    
    func testNavigationTitle() {
        XCTAssertEqual(sut.navigationTitle, "Explore")
    }
    
    func testFetchFriends() {
        // Given:
        XCTAssertTrue(sut.friends.isEmpty)
        
        // When:
        sut.fetchFriends()
        
        // Then:
        XCTAssertEqual(sut.friends.count, 10)
    }
}
