//
//  ProfileView.swift
//  ReelsPractice
//
//  Created by Michael Ma on 2024/5/14.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ProfileHeaderView(user: viewModel.user)
                    
                    PostGridView()
                }
                .padding(.top)
            }
            .navigationTitle(viewModel.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
