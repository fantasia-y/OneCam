//
//  FirstStepView.swift
//  OneCam
//
//  Created by Gordon on 08.02.24.
//

import SwiftUI

struct FirstStepView: View {
    @Binding var selection: Int
    let onFinish: () -> ()
    
    var body: some View {
        VStack {
            Text("Test")
            
            Spacer()
            
            HStack {
                CustomButton("Back") {
                    withAnimation {
                        selection -= 1
                    }
                }
                .style(.secondary)
                
                CustomButton("Finish") {
                    onFinish()
                }
            }
        }
        .padding()
    }
}

#Preview {
    FirstStepView(selection: .constant(2)) {
        
    }
}
