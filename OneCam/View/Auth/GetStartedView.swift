//
//  GetStartedView.swift
//  OneCam
//
//  Created by Gordon on 08.02.24.
//

import SwiftUI

struct GetStartedView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to OneCam")
                .font(.title)
                .bold()
                .padding(.top, 25)
            
            Text("The easiest way to share images with your friends")
                .multilineTextAlignment(.center)
            
            // TODO get started image
        }
    }
}

#Preview {
    GetStartedView()
}
