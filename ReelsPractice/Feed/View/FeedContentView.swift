//
//  FeedContentView.swift
//  ReelsPractice
//
//  Created by Michael Ma on 2024/5/14.
//

import SwiftUI
import AVKit

struct FeedContentView: View {
    
    var post: Post
    var player: AVPlayer
    
    init(post: Post, player: AVPlayer) {
        self.post = post
        self.player = player
    }
        
    var body: some View {
        ZStack {
            CustomVideoPlayer(player: player)
            .containerRelativeFrame([.horizontal, .vertical])
            
            VStack {
                Spacer()
                
                HStack(alignment: .bottom) {
                    videoInfoView()
                    
                    Spacer()
                    
                    functionStackView()
                }
                .padding(.bottom, 88)
            }
            .padding()
        }
        .onTapGesture {
            playerTapHandler()
        }
    }
    
    private func videoInfoView() -> some View {
        VStack(alignment: .leading) {
            Text(post.video.title)
                .fontWeight(.semibold)
            
            Text(post.video.desc)
                .lineLimit(3)
        }
        .foregroundColor(.white)
        .font(.subheadline)
    }
    
    private func functionStackView() -> some View {
        VStack(spacing: 12) {
            
            Circle()
                .frame(width: 48, height: 48)
                .foregroundColor(.gray)
            
            Button {
                print("Likes")
            } label: {
                VStack {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                    
                    Text(numberLimitHelper(post.likes))
                        .font(.caption)
                        .foregroundColor(.white)
                        .bold()
                }
            }
            
            Button {
                print("comments")
            } label: {
                VStack {
                    Image(systemName: "ellipsis.bubble.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                    
                    Text(numberLimitHelper(post.comments))
                        .font(.caption)
                        .foregroundColor(.white)
                        .bold()
                }
            }
            
            Button {
                print("Save")
            } label: {
                Image(systemName: "bookmark.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
            }
            
            Button {
                print("Share")
            } label: {
                Image(systemName: "arrowshape.turn.up.right.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
            }
        }
    }
    
    private func numberLimitHelper(_ num: Int) -> String {
        num > 9999 ? "9999+" : "\(num)"
    }
    
    // MARK: - Handler
    func playerTapHandler() {
        switch player.timeControlStatus {
        case .paused:
            player.play()
        case .waitingToPlayAtSpecifiedRate:
            break
        case .playing:
            player.pause()
        @unknown default:
            break
        }
    }
}

#Preview {
    FeedContentView(post: Post(
        video: VideoModel(
            urlString: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
            title: "abc.happy.life",
            desc: "There is one happy dog.There is one happy dog.There is one happy dog.There is one happy dog.There is one happy dog.There is one happy dog.There is one happy dog.There is one happy dog.There is one happy dog.There is one happy dog.There is one happy dog."),
        likes: 123123123,
        comments: 2343),
                    player: AVPlayer())
}
