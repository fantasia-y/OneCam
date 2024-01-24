//
//  ShareSessionView.swift
//  OneCam
//
//  Created by Gordon on 11.12.23.
//

import SwiftUI
import GordonKirschUtils

struct ShareGroupView: View {
    let session: Group
    
    var body: some View {
        Image(uiImage: QRCodeUtils.generate(forSession: session))
            .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
        
        ShareLink(item: URLUtils.generateShareUrl(forSession: session))
    }
}

#Preview {
    ShareGroupView(session: Group.Example)
}
