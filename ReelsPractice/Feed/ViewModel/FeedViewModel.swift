//
//  FeedViewModel.swift
//  ReelsPractice
//
//  Created by Michael Ma on 2024/5/14.
//

import Foundation
import AVKit
import Combine

class FeedViewModel: ObservableObject {
    
    @Published var posts = [Post]()
    @Published var error: Swift.Error?
    
    lazy var uiQueue = DispatchQueue.main
    lazy var ioQueue = DispatchQueue.global()
    
    private let feedsCacheManager: FeedsCacheManaging
    private let feedsProvider: FeedsProviding
    init(
        feedsCacheManager: FeedsCacheManaging = FeedsCacheManager.shared,
        feedsProvider: FeedsProviding = FakeFeedsService()
    ) {
        self.feedsCacheManager = feedsCacheManager
        self.feedsProvider = feedsProvider
    }
    
    func getFeedsPlayerItem(at index: Int) -> AVPlayerItem? {
        guard index < posts.count else { return nil }
        let post = posts[index]
        if let playerItem = feedsCacheManager.getPlayerItem(urlString: post.video.urlString) {
            return playerItem
        } else {
            let urlString = post.video.urlString
            let url = URL(string: urlString)!
            let playerItem = AVPlayerItem(url: url)
            feedsCacheManager.cachePlayerItem(urlString: urlString, item: playerItem)
            return playerItem
        }
    }
    
    func fetchPosts() {
        feedsProvider.fetchFeeds { [weak self] result in
            switch result {
            case .success(let posts):
                self?.uiQueue.async {
                    self?.posts = posts
                    self?.preload(from: 0, to: posts.count)
                }
            case .failure(let error):
                self?.error = error
            }
        }
    }
    
    private func preload(from: Int, to: Int) {
        ioQueue.async { [weak self] in
            guard let self else { return }
            guard from < to else { return }
            
            for i in from..<to {
                let urlString = self.posts[i].video.urlString
                self.feedsCacheManager.preloadVideo(urlString: urlString)
            }
        }
    }
}
