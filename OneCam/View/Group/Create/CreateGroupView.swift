//
//  CreateSession.swift
//  OneCam
//
//  Created by Gordon on 16.11.23.
//

import SwiftUI

struct CreateGroupView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @StateObject var viewModel = CreateGroupViewModel()
    
    @Binding var showCreateGroup: Bool
    @State var showPreview: Bool = false
    
    var body: some View {
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
        .environmentObject(viewModel)
        .toolbar() {
            Button("Cancel") {
                showCreateGroup = false
            }
        }
    }
}

#Preview {
    CreateGroupView(showCreateGroup: .constant(true))
        .environmentObject(HomeViewModel())
}
