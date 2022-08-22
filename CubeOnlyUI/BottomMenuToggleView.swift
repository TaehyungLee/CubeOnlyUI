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
                        .padding(.top)
                    Divider()
                        .background(Color.gray)
                        .frame(width: 30, height: 2)
                    Spacer()
                }
                .frame(maxWidth:.infinity, maxHeight: .infinity)
            }
        }
    }
}

