//
//  ProfileView.swift
//  OneCam
//
//  Created by Gordon on 24.01.24.
//

import SwiftUI
import UIKit

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authenticatedViewModel: AuthenticatedViewModel
    @EnvironmentObject var userData: UserData
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        SheetWrapper { path in
            if let currentUser = userData.currentUser {
                VStack {
                    Card {
                        HStack {
                            Avatar(user: currentUser)
                                .size(.medium)
                            
                            VStack(alignment: .leading) {
                                Text(currentUser.displayname ?? "Displayname")
                                    .bold()
                                
                                Text(currentUser.email ?? "E-Mail")
                                    .foregroundStyle(.gray)
                            }
                            
                            Spacer()
                        }
                        .padding()
                    }
                    
                    Button("Edit") {
                        path.wrappedValue.append(currentUser)
                    }
                    .secondary()
                    .navigationDestination(for: User.self) { _ in
                        ProfileEditView(path: path)
                            .navigationTitle("Edit")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Settings")
                            .bold()
                            .padding(.top, 15)
                        
                        Card {
                            VStack(spacing: 0) {
                                CardListButton(text: "Dark Mode") {
                                    
                                }
                                
                                CardDivider()
                                
                                CardListButton(text: "Notifications") {
                                    
                                }
                            }
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("About")
                            .bold()
                            .padding(.top, 15)
                        
                        Card {
                            VStack(spacing: 0) {
                                CardListButton(text: "Rate us") {
                                    
                                }
                                
                                CardDivider()
                                
                                CardListButton(text: "Help") {
                                    
                                }
                                
                                CardDivider()
                                
                                CardListButton(text: "About us") {
                                    
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    AsyncButton("Logout") {
                        await authenticatedViewModel.logout()
                        dismiss()
                    }
                    .destructive()
                    
                    Text("Version 1.0.0")
                        .font(.subheadline)
                        .foregroundStyle(Color("textSecondary"))
                }
                .navigationTitle("Settings")
            }
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthenticatedViewModel())
        .environmentObject(UserData(currentUser: User.Example))
}
