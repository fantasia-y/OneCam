//
//  ShareSessionView.swift
//  OneCam
//
//  Created by Gordon on 11.12.23.
//

import SwiftUI
import GordonKirschUtils

struct ShareSessionView: View {
    let session: Session
    
    var body: some View {
        Image(uiImage: QRCodeUtils.generate(forSession: session))
            .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
        
        ShareLink(item: URLUtils.generateShareUrl(forSession: session))
    }
}

#Preview {
    ShareSessionView(session: Session.Example)
}
