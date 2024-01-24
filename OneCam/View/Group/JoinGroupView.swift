//
//  JoinSessionView.swift
//  OneCam
//
//  Created by Gordon on 22.11.23.
//

import SwiftUI
import CodeScanner

struct JoinGroupView: View {
    @Binding var showCodeScanner: Bool
    
    @State private var path: [String] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            CodeScannerView(codeTypes: [.qr], showViewfinder: true, simulatedData: "https://lamb-uncommon-goose.ngrok-free.app/join/df46e7ba-140d-4721-8b9e-a359dce5e78a") { result in
                switch(result) {
                case .success(let data):
                    if let url = URL(string: data.string), URLUtils.isOwnHost(url) {
                        if let groupId = UUID(uuidString: url.lastPathComponent) {
                            path.append(groupId.uuidString.lowercased())
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
            .toolbar() {
                Button("Cancel") {
                    showCodeScanner = false
                }
            }
            .navigationDestination(for: String.self) { id in
                PreviewGroupView(showCodeScanner: $showCodeScanner, id: id)
                    .toolbar() {
                        Button("Cancel") {
                            showCodeScanner = false
                        }
                    }
            }
        }
    }
}

#Preview {
    JoinGroupView(showCodeScanner: .constant(true))
}
