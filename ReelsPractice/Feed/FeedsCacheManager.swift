//
//  FeedsCacheManager.swift
//  ReelsPractice
//
//  Created by Michael Ma on 2024/5/15.
//

import Foundation
import AVKit

protocol FeedsCacheManaging {
    func preloadVideo(urlString: String)
    func getPlayerItem(urlString: String) -> AVPlayerItem?
    func cachePlayerItem(urlString: String, item: AVPlayerItem)
}

final class FeedsCacheManager: FeedsCacheManaging {
    static let shared = FeedsCacheManager()
    
    private var cache = NSCache<NSString, AVPlayerItem>()
    
    func preloadVideo(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let asset = AVURLAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        cache.setObject(playerItem, forKey: NSString(string: urlString))
    }
    
    func getPlayerItem(urlString: String) -> AVPlayerItem? {
        cache.object(forKey: NSString(string: urlString))
    }
    
    func cachePlayerItem(urlString: String, item: AVPlayerItem) {
        cache.setObject(item, forKey: NSString(string: urlString))
    }
}
