//
//  OnboardingView.swift
//  OneCam
//
//  Created by Gordon on 08.02.24.
//

import SwiftUI
import SwiftUIIntrospect

struct OnboardingView: View {
    @EnvironmentObject var contentViewModel: ContentViewModel
    
    @State var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            AccountSetupView() {
                withAnimation { // TODO fix animation
                    selection += 1
                }
            }
            .tag(1)
            
            FirstStepView(selection: $selection) {
                withAnimation {
                    contentViewModel.finishOnboarding()
                }
            }
            .tag(2)
            .contentShape(Rectangle()).gesture(DragGesture())
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .introspect(.tabView(style: .page), on: .iOS(.v17)) { tabView in
            tabView.gestureRecognizers?.removeAll()
        }
    }
}

#Preview {
    OnboardingView()
}
