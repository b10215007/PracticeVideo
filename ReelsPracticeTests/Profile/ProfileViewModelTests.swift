//
//  ProfileViewModelTests.swift
//  ReelsPracticeTests
//
//  Created by Michael Ma on 2024/5/22.
//

import XCTest
import Combine
@testable import ReelsPractice

final class ProfileViewModelTests: XCTestCase {
    
    private var sut: ProfileViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ProfileViewModel()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testInit() {
        XCTAssertEqual(sut.user.name, "Visitor")
        XCTAssertNil(sut.user.avatarUrlString)
    }
    
    func testNavigationTitle() {
        XCTAssertEqual(sut.navigationTitle, "Profile")
    }
    
    func testFetchUser() {
        // Given:
        let expectation = expectation(description: #function)
        XCTAssertEqual(sut.user.name, "Visitor")
        XCTAssertNil(sut.user.avatarUrlString)
        
        // When:
        var cancellable: AnyCancellable?
        cancellable = sut.$user
            .dropFirst()
            .sink { value in
                XCTAssertEqual(value.name, "User")
                XCTAssertEqual(value.avatarUrlString, "TestAvatar")
                cancellable?.cancel()
                expectation.fulfill()
            }
        sut.fetchUser()
        
        // Then:
        wait(for: [expectation], timeout: 0.1)
    }
}
