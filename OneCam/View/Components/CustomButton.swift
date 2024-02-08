//
//  CustomButton.swift
//  OneCam
//
//  Created by Gordon on 08.02.24.
//

import SwiftUI

enum ButtonStyle {
    case primary
    case secondary
}

struct ButtonStyleKey: EnvironmentKey {
    static var defaultValue: ButtonStyle = .primary
}

extension EnvironmentValues {
  var buttonStyle: ButtonStyle {
    get { self[ButtonStyleKey.self] }
    set { self[ButtonStyleKey.self] = newValue }
  }
}

struct CustomButton: View {
    @Environment(\.buttonStyle) var buttonStyle
    
    let text: String
    let loading: Bool
    let action: () async -> ()
    
    var buttonColor: Color {
        switch buttonStyle {
        case .primary:
            return Color("buttonPrimary")
        case .secondary:
            return Color("buttonSecondary")
        }
    }
    
    var textColor: Color {
        switch buttonStyle {
        case .primary:
            return .white
        case .secondary:
            return Color("textPrimary")
        }
    }
    
    init(_ text: String, action: @escaping () async -> ()) {
        self.text = text
        self.loading = false
        self.action = action
    }
    
    init(_ text: String, loading: Bool, action: @escaping () async -> ()) {
        self.text = text
        self.loading = loading
        self.action = action
    }
    
    var body: some View {
        Button() {
            Task {
                await action()
            }
        } label: {
            if loading {
                ProgressView()
                    .frame(maxWidth: .infinity)
            } else {
                Text(text)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .background(buttonColor)
        .foregroundColor(textColor)
        .cornerRadius(10)
        .disabled(loading)
    }
}

extension CustomButton {
  func style(_ style: ButtonStyle) -> some View {
      environment(\.buttonStyle, style)
  }
}

#Preview {
    VStack {
        CustomButton("Test") {
            print("Test")
        }
        
        CustomButton("Test", loading: true) {
            print("Test")
        }
    }
}
