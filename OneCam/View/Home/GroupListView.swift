//
//  GroupListView.swift
//  OneCam
//
//  Created by Gordon on 24.01.24.
//

import SwiftUI
import CachedAsyncImage

struct GroupListView: View {
    let group: Group
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            CachedAsyncImage(url: URL(string: group.urls[FilterType.none.rawValue]!)!) { phase in
                switch phase {
                case .empty:
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("buttonSecondary"))
                            .frame(height: 180)
                        
                        ProgressView()
                    }
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 180)
                        .contentShape(Rectangle())
                        .clipped()
                case .failure:
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("buttonSecondary"))
                            .frame(height: 180)
                        
                        Image(systemName: "questionmark")
                            .foregroundStyle(.white)
                    }
                @unknown default:
                    EmptyView()
                }
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(group.name)
                        .bold()
                    
                    Text("\(group.imageCount) image\(group.imageCount != 1 ? "s" : "")")
                        .font(.subheadline)
                        .foregroundStyle(Color("textSecondary"))
                }
                
                Spacer()
            }
            .padding()
            .background(.thinMaterial)
            .frame(maxWidth: .infinity)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    GroupListView(group: Group.Example)
}
