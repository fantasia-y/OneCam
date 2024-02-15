//
//  ShareSessionView.swift
//  OneCam
//
//  Created by Gordon on 11.12.23.
//

import SwiftUI
import GordonKirschUtils

struct ShareGroupView: View {
    let group: Group
    
    var body: some View {
        Image(uiImage: QRCodeUtils.generate(forGroup: group))
            .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
        
        ShareLink(item: URLUtils.generateShareUrl(forGroup: group))
    }
}

#Preview {
    ShareGroupView(group: Group.Example)
}
