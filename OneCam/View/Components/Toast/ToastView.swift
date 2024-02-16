//
//  ToastView.swift
//  OneCam
//
//  Created by Gordon on 16.02.24.
//

import SwiftUI

struct Toast: Equatable {
    var style: ToastStyle
    var message: String
    var duration: Double = 3
    var width: Double = .infinity
    
    static let Error = Toast(style: .error, message: "An error occured")
}

enum ToastStyle {
    case error
    case warning
    case success
    case info
}

extension ToastStyle {
    var themeColor: Color {
        switch self {
        case .error: return Color.red
        case .warning: return Color.orange
        case .info: return Color.blue
        case .success: return Color.green
        }
    }
  
    var iconFileName: String {
        switch self {
        case .info: return "info.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        }
    }
}

struct ToastView: View {
    var style: ToastStyle
    var message: String
    var width = CGFloat.infinity
    var onCancelTapped: (() -> Void)
  
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: style.iconFileName)
                .foregroundColor(style.themeColor)
            
            Text(message)
                .font(.subheadline)
                .bold()
                .foregroundColor(Color("textPrimary"))
          
            Spacer(minLength: 10)
          
            Button {
                onCancelTapped()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(Color("textPrimary"))
            }
        }
        .padding()
        .frame(minWidth: 0, maxWidth: width)
        .background(Color("buttonSecondary"))
        .cornerRadius(10)
        .padding(.horizontal, 16)
    }
}

#Preview {
    VStack {
        ToastView(style: .success, message: "Toast") {
            
        }
        
        ToastView(style: .info, message: "Toast") {
            
        }
        
        ToastView(style: .warning, message: "Toast") {
            
        }
        
        ToastView(style: .error, message: "Toast") {
            
        }
    }
}
