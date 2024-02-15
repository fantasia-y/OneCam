//
//  SheetWrapper.swift
//  OneCam
//
//  Created by Gordon on 15.02.24.
//

import SwiftUI

struct SheetWrapper<Content: View>: View {
    let padding: Edge.Set?
    let sheetContent: () -> Content
    
    init(padding: Edge.Set? = .all, @ViewBuilder sheetContent: @escaping () -> Content) {
        self.sheetContent = sheetContent
        self.padding = padding
    }
    
    var body: some View {
        NavigationStack {
            sheetContent()
                .toolbar() {
                    CloseButton()
                }
                .if(padding != nil) { view in
                    view.padding(padding!)
                }
        }
    }
}
