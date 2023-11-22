//
//  JoinSessionView.swift
//  OneCam
//
//  Created by Gordon on 22.11.23.
//

import SwiftUI
import CodeScanner

struct JoinSessionView: View {
    @Binding var showCodeScanner: Bool
    
    @State private var path: [String] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            CodeScannerView(codeTypes: [.qr], showViewfinder: true, simulatedData: "Test Data") { result in
                switch(result) {
                case .success(let data):
                    if let url = URL(string: data.string), URLUtils.isOwnHost(url) {
                        if let sessionId = UUID(uuidString: url.lastPathComponent) {
                            path.append(sessionId.uuidString)
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
            .navigationDestination(for: String.self) { string in
                Text(string)
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
    JoinSessionView(showCodeScanner: .constant(true))
}
