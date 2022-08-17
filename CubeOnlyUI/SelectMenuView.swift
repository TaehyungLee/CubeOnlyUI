//
//  SelectMenuView.swift
//  CubeSetting
//
//  Created by Taehyung Lee on 2022/08/17.
//

import SwiftUI

struct SelectMenuView: View {
    
    var titleStr:String
    @Binding var valueStr:String
    var action:()->Void
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text(titleStr)
                    .font(Font.system(size: 15))
                Spacer()
                Button {
                    action()
                } label: {
                    Text(valueStr)
                }
            }
            Spacer()
            Divider()
        }
        .frame(height: 50)
        
    }
}

