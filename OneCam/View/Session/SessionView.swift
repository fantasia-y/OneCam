//
//  SessionView.swift
//  OneCam
//
//  Created by Gordon on 12.12.23.
//

import SwiftUI

struct SessionView: View {
    let session: Session
    
    @State var showSessionPreview = false
    
    var body: some View {
        VStack {
            
        }
        .navigationTitle(session.name)
        .toolbar() {
            Button("", systemImage: "square.and.arrow.up") {
                showSessionPreview = true
            }
        }
        .sheet(isPresented: $showSessionPreview) {
            ShareSessionView(session: session)
        }
    }
}

#Preview {
    SessionView(session: Session.Example)
}
