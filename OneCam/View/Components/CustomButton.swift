//
//  CustomButton.swift
//  OneCam
//
//  Created by Gordon on 08.02.24.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    let isEnabled: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .bold()
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("buttonPrimary"))
            .foregroundColor(.white)
            .cornerRadius(10)
            .opacity(isEnabled ? 1.0 : 0.8)
    }
}

struct PrimaryButtonModifier: ViewModifier {
    @Environment(\.isEnabled) var isEnabled
    
    func body(content: Content) -> some View {
        content
            .buttonStyle(PrimaryButtonStyle(isEnabled: isEnabled))
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    let isEnabled: Bool

    func makeBody(configuration: Configuration) -> some View {
        return configuration
            .label
            .bold()
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("buttonSecondary"))
            .foregroundColor(Color("textPrimary"))
            .cornerRadius(10)
            .opacity(isEnabled ? 1.0 : 0.8)
    }
}

struct SecondaryButtonModifier: ViewModifier {
    @Environment(\.isEnabled) var isEnabled
    
    func body(content: Content) -> some View {
        content
            .buttonStyle(SecondaryButtonStyle(isEnabled: isEnabled))
    }
}

extension Button {
    func primary(isLoading: Bool = false) -> some View {
        modifier(PrimaryButtonModifier())
    }
    
    func secondary(isLoading: Bool = false) -> some View {
        modifier(SecondaryButtonModifier())
    }
}

struct AsyncButton<Label: View>: View {
    var action: () async -> Void
    @ViewBuilder var label: () -> Label

    @State private var isPerformingTask = false

    func primary(isLoading: Bool = false) -> some View {
        modifier(PrimaryButtonModifier())
    }
    
    func secondary(isLoading: Bool = false) -> some View {
        modifier(SecondaryButtonModifier())
    }
    
    var body: some View {
        Button(
            action: {
                isPerformingTask = true
            
                Task {
                    await action()
                    isPerformingTask = false
                }
            },
            label: {
                ZStack {
                    // We hide the label by setting its opacity
                    // to zero, since we don't want the button's
                    // size to change while its task is performed:
                    label().opacity(isPerformingTask ? 0 : 1)

                    if isPerformingTask {
                        ProgressView()
                    }
                }
            }
        )
        .disabled(isPerformingTask)
        .opacity(isPerformingTask ? 0.8 : 1)
    }
}

extension AsyncButton where Label == Text {
    init(_ titleKey: String, action: @escaping () async -> Void) {
        self.init(action: action) {
            Text(titleKey)
        }
    }
}

#Preview {
    VStack {
        Button("Normal") {
            print("Normal")
        }
        .primary()
        
        Button("Normal") {
            print("Normal")
        }
        .secondary()
        
        Button("Disabled") {
            print("Disabled")
        }
        .primary()
        .disabled(true)
        
        Button("Disabled") {
            print("Disabled")
        }
        .secondary()
        .disabled(true)
        
        AsyncButton("Loading") {
            print("Loading")
        }
        .primary()
        
        AsyncButton("Loading") {
            print("Loading")
        }
        .secondary()
    }
}
