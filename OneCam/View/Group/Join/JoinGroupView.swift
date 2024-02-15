//
//  JoinSessionView.swift
//  OneCam
//
//  Created by Gordon on 22.11.23.
//

import SwiftUI
import CodeScanner

struct JoinGroupView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = JoinGroupViewModel()
    
    var body: some View {
        NavigationStack {
            CarouselView(page: $viewModel.page) {
                CodeScannerView(codeTypes: [.qr], showViewfinder: true, simulatedData: "https://lamb-uncommon-goose.ngrok-free.app/join/df46e7ba-140d-4721-8b9e-a359dce5e78a") { result in
                    switch(result) {
                    case .success(let data):
                        if let url = URL(string: data.string), URLUtils.isOwnHost(url) {
                            if let groupId = UUID(uuidString: url.lastPathComponent) {
                                viewModel.groupId = groupId.uuidString.lowercased()
                                viewModel.page += 1
                            } else {
                                // TODO correct host, invalid url
                            }
                        } else {
                            // TODO invalid host
                        }
                        
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                        break
                    }
                }
                .tag(1)
                
                JoinGroupPreviewView()
                    .environmentObject(viewModel)
                    .tag(2)
            }
            .toolbar() {
                CloseButton()
            }
        }
    }
}

#Preview {
    JoinGroupView()
        .environmentObject(JoinGroupViewModel())
}
