//
//  SessionView.swift
//  OneCam
//
//  Created by Gordon on 12.12.23.
//

import SwiftUI

struct GroupView: View {
    let group: Group
    
    @State var showShareView = false
    @State var showSettings = false
    
    var body: some View {
        VStack {
            
        }
        .navigationTitle(group.name)
        .sheet(isPresented: $showSettings) {
            GroupSettingsView(group: group, showSettings: $showSettings)
        }
        .toolbar() {
            Button {
                showShareView = true
            } label: {
                Image(systemName: "square.and.arrow.up")
            }
            
            Button {
                showSettings = true
            } label: {
                Image(systemName: "gearshape")
            }
        }
        .sheet(isPresented: $showShareView) {
            ShareGroupView(session: group)
        }
    }
}

#Preview {
    GroupView(group: Group.Example)
}
