//
//  FeedViewModelTests.swift
//  ReelsPracticeTests
//
//  Created by Michael Ma on 2024/5/22.
//

import XCTest
import AVFoundation
import Combine
@testable import ReelsPractice

final class FeedViewModelTests: XCTestCase {
    
    private var feedsCacheManager: MockFeedsCacheManaging!
    private var feedsProvider: MockFeedsProviding!
    private var sut: FeedViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        feedsCacheManager = MockFeedsCacheManaging()
        feedsProvider = MockFeedsProviding()
        sut = FeedViewModel(feedsCacheManager: feedsCacheManager, feedsProvider: feedsProvider)
    }
    
    override func tearDownWithError() throws {
        feedsCacheManager = nil
        feedsProvider = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func testFetchPostsFail() {
        // Given:
        let expected = expectation(description: #function)
        feedsProvider.result = .failure(TestError.customError(message: "failed"))
        
        // When:
        var cancellable: AnyCancellable?
        cancellable = sut.$error
            .dropFirst()
            .sink { value in
                XCTAssertTrue(value is TestError)
                cancellable?.cancel()
                expected.fulfill()
            }
        sut.fetchPosts()
        
        // Then:
        wait(for: [expected], timeout: 0.1)
    }
    
    func testFetchPostsSuccess() {
        // Given:
        let expected = expectation(description: #function)
        let count = 10
        feedsProvider.result = .success(makePosts(count))
        
        // When:
        var cancellable: AnyCancellable?
        cancellable = sut.$posts
            .dropFirst()
            .sink { value in
                XCTAssertEqual(value.count, count)
                XCTAssertEqual(value[0].video.title, "title1")
                XCTAssertEqual(value[0].video.desc, "desc1")
                XCTAssertEqual(value[0].comments, 1)
                XCTAssertEqual(value[0].likes, 1)
                cancellable?.cancel()
                expected.fulfill()
            }
        sut.fetchPosts()
        
        // Then:
        wait(for: [expected], timeout: 0.1)
        XCTAssertEqual(feedsProvider.fetchFeedsBeCalled, 1)
    }
    
    func testGetFeedsPlayerItemNil() {
        // Given:
        let count = 10
        feedsProvider.result = .success(makePosts(count))
        sut.fetchPosts()
        feedsCacheManager.playerItem = AVPlayerItem(url: URL(string: "urlString1")!)
        
        // When:
        let result = sut.getFeedsPlayerItem(at: 1000)
        
        // Then:
        XCTAssertNil(result)
        XCTAssertTrue(feedsCacheManager.getPlayerItemBeCalled.isEmpty)
        XCTAssertTrue(feedsCacheManager.cachePlayerItemBeCalled.isEmpty)
    }
    
    func testGetFeedsPlayerItemFromCache() {
        // Given:
        sut.posts = makePosts(3)
        feedsCacheManager.playerItem = AVPlayerItem(url: URL(string: "urlString1")!)
        
        // When:
        let result = sut.getFeedsPlayerItem(at: 0)
        
        // Then:
        XCTAssertNotNil(result)
        XCTAssertEqual(feedsCacheManager.getPlayerItemBeCalled.count, 1)
        XCTAssertEqual(feedsCacheManager.getPlayerItemBeCalled[0], "urlString1")
        XCTAssertTrue(feedsCacheManager.cachePlayerItemBeCalled.isEmpty)
    }
    
    func testGetFeedsPlayerItemAndCreateNewOne() {
        // Given:
        sut.posts = makePosts(3)
        
        // When:
        let result = sut.getFeedsPlayerItem(at: 0)
        
        // Then:
        XCTAssertNotNil(result)
        XCTAssertEqual(feedsCacheManager.getPlayerItemBeCalled.count, 1)
        XCTAssertEqual(feedsCacheManager.getPlayerItemBeCalled[0], "urlString1")
        XCTAssertEqual(feedsCacheManager.cachePlayerItemBeCalled.count, 1)
        XCTAssertEqual(feedsCacheManager.cachePlayerItemBeCalled[0].0, "urlString1")
    }
}

extension FeedViewModelTests {
    
    private func makePosts(_ count: Int) -> [Post] {
        var result = [Post]()
        for i in 1...count {
            let video = VideoModel(urlString: "urlString\(i)", title: "title\(i)", desc: "desc\(i)")
            result.append(Post(video: video, likes: i, comments: i))
        }
        return result
    }
}

private class MockFeedsCacheManaging: FeedsCacheManaging {
    
    var preloadVideoBeCalled: [String] = []
    func preloadVideo(urlString: String) {
        preloadVideoBeCalled.append(urlString)
    }
    
    var getPlayerItemBeCalled: [String] = []
    var playerItem: AVPlayerItem? = nil
    func getPlayerItem(urlString: String) -> AVPlayerItem? {
        getPlayerItemBeCalled.append(urlString)
        return playerItem
    }
    
    var cachePlayerItemBeCalled: [(String, AVPlayerItem)] = []
    func cachePlayerItem(urlString: String, item: AVPlayerItem) {
        cachePlayerItemBeCalled.append((urlString, item))
    }
}

private class MockFeedsProviding: FeedsProviding {
    
    var result: Result<[ReelsPractice.Post], any Error>!
    var fetchFeedsBeCalled: Int = 0
    func fetchFeeds(completion: @escaping (Result<[ReelsPractice.Post], any Error>) -> Void) {
        fetchFeedsBeCalled += 1
        completion(result)
    }
}
