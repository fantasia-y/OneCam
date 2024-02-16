//
//  SheetWrapper.swift
//  OneCam
//
//  Created by Gordon on 15.02.24.
//

import SwiftUI

struct SheetWrapper<Content: View>: View {
    let title: String?
    let padding: Edge.Set?
    let sheetContent: () -> Content
    
    init(title: String? = nil, padding: Edge.Set? = .all, @ViewBuilder sheetContent: @escaping () -> Content) {
        self.sheetContent = sheetContent
        self.padding = padding
        self.title = title
    }
    
    var body: some View {
        NavigationStack {
            sheetContent()
                .navigationTitle(title ?? "")
                .toolbar() {
                    CloseButton()
                }
                .if(padding != nil) { view in
                    view.padding(padding!)
                }
        }
    }
}
