//
//  FeedView.swift
//  ReelsPractice
//
//  Created by Michael Ma on 2024/5/14.
//

import SwiftUI
import AVKit

struct FeedView: View {
    
    @StateObject var viewModel = FeedViewModel()
    @State private var isFirstLoaded = true
    @State private var scrollPosition: String?
    @State private var player = AVPlayer()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.posts) { post in
                    FeedContentView(post: post, player: player)
                        .id(post.id)
                        .onAppear {
                            playInitialVideoIfNeeded()
                        }
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: $scrollPosition)
        .scrollTargetBehavior(.paging)
        .ignoresSafeArea()
        .onAppear {
            if isFirstLoaded {
                isFirstLoaded = false
                viewModel.fetchPosts()
            } else {
                play()
            }
        }
        .onDisappear {
            stop()
        }
        .onChange(of: scrollPosition) { oldValue, newValue in
            playVideoWhenChangeScrollPosition(id: newValue)
        }
    }
    
    private func stop() {
        player.pause()
    }
    
    private func play() {
        player.play()
    }
    
    private func playInitialVideoIfNeeded() {
        guard scrollPosition == nil ,
              let post = viewModel.posts.first,
              player.currentItem == nil else {
            return
        }
        
        let playItem = AVPlayerItem(url: URL(string: post.video.urlString)!)
        player.replaceCurrentItem(with: playItem)
        player.play()
    }
    
    private func playVideoWhenChangeScrollPosition(id: String?) {
        guard let index = viewModel.posts.firstIndex(where: { $0.id == id }) else { return }
        guard let playItem = viewModel.getFeedsPlayerItem(at: index) else { return }
        
        player.pause()        
        player.replaceCurrentItem(with: playItem)
        player.play()
    }
}
