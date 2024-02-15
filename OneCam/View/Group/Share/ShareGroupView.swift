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
        SheetWrapper {
            GeometryReader { geometry in
                VStack {
                    Text("Let your friends scan this QR Code...")
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("buttonSecondary"))
                            .frame(width: geometry.size.width, height: geometry.size.width)
                        
                        Image(uiImage: QRCodeUtils.generate(forGroup: group))
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width - 25, height: geometry.size.width - 25)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    
                    HStack {
                        VStack { Divider() }
                        Text("or")
                        VStack { Divider() }
                    }
                    .padding()
                    
                    Text("...send them a link to join this group")
                    
                    ShareLink(item: URLUtils.generateShareUrl(forGroup: group))
                        .modifier(PrimaryButtonModifier())
                }
            }
        }
    }
}

#Preview {
    ShareGroupView(group: Group.Example)
}
