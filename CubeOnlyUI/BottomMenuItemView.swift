//
//  BottomMenuItemView.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/08/22.
//

import Foundation
import SwiftUI

struct BottomMenuItemView: View {
    var imgStr:String
    
    var isEnable:Bool = true
    var badgeCount:Int = 0
    var action:()->Void
    var body: some View {
        VStack {
            Button {
                self.action()
            } label: {
                ZStack {
                    Image(imgStr)
                        .resizable()
                        .frame(width: 24, height: 24)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
            }
        }
    }
}
