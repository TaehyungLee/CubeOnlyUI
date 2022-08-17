//
//  CheckMenuView.swift
//  CubeSetting
//
//  Created by Taehyung Lee on 2022/08/17.
//

import SwiftUI

struct CheckMenuView: View {
    
    var imageStr:String
    var titleStr:String
    @Binding var isChecked:Bool
    var action:()->Void
    var body: some View {
        VStack {
            HStack {
                Image(imageStr)
                    .resizable()
                    .frame(width: 16, height: 16, alignment: .center)
                Text(titleStr)
                    .font(Font.system(size: 15))
                    .padding(.leading)
                Spacer()
                Button {
                    action()
                } label: {
                    Image(isChecked ? "invite-check-on":"invite-check-off")
                        .resizable()
                        .frame(width: 22, height: 22, alignment: .center)
                        .padding(.trailing)
                }
            }
            
            Divider()
        }
        .frame(height: 50)
    }
}
