//
//  CreateSession.swift
//  OneCam
//
//  Created by Gordon on 16.11.23.
//

import SwiftUI

struct CreateGroupView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var homeViewModel: HomeViewModel
    @StateObject var viewModel = CreateGroupViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Text("Create a new Group")
                    .font(.title)
                    .bold()
                    .padding(.top, 25)
                
                CarouselView(page: $viewModel.page) {
                    CreateGroupNameView()
                        .tag(1)
                    
                    CreateGroupImageView()
                        .tag(2)
                    
                    CreateGroupPreviewView()
                        .tag(3)
                }
            }
            .toolbar() {
                CloseButton()
            }
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    CreateGroupView()
        .environmentObject(HomeViewModel())
}
