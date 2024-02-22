//
//  DarkModeSettingsView.swift
//  OneCam
//
//  Created by Gordon on 20.02.24.
//

import SwiftUI

struct DarkModeSettingsView: View {
    @EnvironmentObject var colorSchemeSetting: ColorSchemeSetting
    
    var values: [ColorScheme] = ColorScheme.allCases
    
    var body: some View {
        VStack {
            Card {
                VStack(spacing: 0) {
                    Button {
                        colorSchemeSetting.colorScheme = nil
                    } label: {
                        Text("System")
                        
                        Spacer()
                        
                        if colorSchemeSetting.colorScheme == nil {
                            Image(systemName: "checkmark")
                        }
                    }
                    .padding()
                    .foregroundStyle(Color("textPrimary"))
                    
                    CardDivider()
                    
                    Button {
                        colorSchemeSetting.colorScheme = .light
                    } label: {
                        Text("Light")

                        Spacer()
                        
                        if colorSchemeSetting.colorScheme == .light {
                            Image(systemName: "checkmark")
                        }
                    }
                    .padding()
                    .foregroundStyle(Color("textPrimary"))
                    
                    CardDivider()
                    
                    Button {
                        colorSchemeSetting.colorScheme = .dark
                    } label: {
                        Text("Dark")
                        
                        Spacer()
                        
                        if colorSchemeSetting.colorScheme == .dark {
                            Image(systemName: "checkmark")
                        }
                    }
                    .padding()
                    .foregroundStyle(Color("textPrimary"))
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Design")
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(colorSchemeSetting.colorScheme)
    }
}

#Preview {
    DarkModeSettingsView()
        .environmentObject(ColorSchemeSetting())
}
