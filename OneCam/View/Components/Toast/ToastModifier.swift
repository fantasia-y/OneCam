//
//  ToastModifier.swift
//  OneCam
//
//  Created by Gordon on 16.02.24.
//

import Foundation
import SwiftUI

struct ToastModifier: ViewModifier {
  
    @Binding var toast: Toast?
    @State private var workItem: DispatchWorkItem?
  
    func body(content: Content) -> some View {
        content
            .overlay() {
                mainToastView()
                    .animation(.spring(), value: toast)
            }
            .onChange(of: toast) { _ in
                showToast()
            }
    }
  
    @ViewBuilder func mainToastView() -> some View {
        if let toast = toast {
            VStack {
                ToastView(
                    style: toast.style,
                    message: toast.message,
                    width: toast.width
                ) {
                    dismissToast()
                }
                
                Spacer()
            }
        }
    }
  
    private func showToast() {
        guard let toast = toast else { return }
    
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    
        if toast.duration > 0 {
            workItem?.cancel()
      
            let task = DispatchWorkItem {
                dismissToast()
            }
      
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
        }
    }
  
    private func dismissToast() {
        withAnimation {
            toast = nil
        }
    
        workItem?.cancel()
        workItem = nil
    }
}
