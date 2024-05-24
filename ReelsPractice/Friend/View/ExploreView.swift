//
//  ExploreView.swift
//  ReelsPractice
//
//  Created by Michael Ma on 2024/5/14.
//

import SwiftUI

struct ExploreView: View {
    
    @State var viewModel = ExploreViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.friends) { user in
                        UserCell(user: user)
                    }
                }
            }
            .navigationTitle(viewModel.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top)
            .onAppear {
                viewModel.fetchFriends()
            }
        }
    }
}
