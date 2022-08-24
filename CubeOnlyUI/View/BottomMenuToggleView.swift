//
//  BottomMenuToggleView.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/08/22.
//

import SwiftUI

struct BottomMenuToggleView: View {
    var action:()->Void
    var body: some View {
        HStack {
            Button {
                action()
            } label: {
                VStack {
                    Spacer()
                    Divider()
                        .background(Color.gray)
                        .frame(width: 30, height: 2)
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    Divider()
                        .background(Color.gray)
                        .frame(width: 30, height: 2)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    Spacer()
                }
                .frame(maxWidth:.infinity, maxHeight: .infinity)
            }
        }
    }
}

