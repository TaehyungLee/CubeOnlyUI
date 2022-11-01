//
//  TransrateView.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/11/01.
//

import SwiftUI

struct TransrateView: View {
    
    @Environment(\.presentationMode) var present
    var body: some View {
        VStack {
            HStack {
                Text("번역하기")
                Spacer()
                Button {
                    present.wrappedValue.dismiss()
                } label: {
                    Text("닫기")
                }
            }
            .padding(.horizontal)
            .frame(height: 55)
            
            GeometryReader { proxy in
                HStack(spacing:0) {
                    Button {
                        
                    } label: {
                        Text("자동감지")
                    }
                    .frame(width: proxy.size.width*0.43, height: 55)
                    .border(Color.init(white: 0.8))
                    ZStack {
                        Rectangle().fill(.green)
                        Text("<->")
                            .foregroundColor(.white)
                    }
                    .frame(width: proxy.size.width*0.14, height: 55)
                    Button {
                        
                    } label: {
                        Text("English")
                    }
                    .frame(width: proxy.size.width*0.43, height: 55)
                    .border(Color.init(white: 0.8))
                }
                .frame(width: proxy.size.width)
                VStack(spacing:0) {
                    VStack {
                        
                    }
                    .frame(height: proxy.size.height/2)
                    ZStack {
                        Rectangle().fill(Color.blue)
                        Text("변역결과")
                    }
                    .frame(height: proxy.size.height/2)
                }
                .fixedSize(horizontal: false, vertical: true)
                .frame(width: proxy.size.width, height: proxy.size.height)
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}

struct TransrateView_Previews: PreviewProvider {
    static var previews: some View {
        TransrateView()
    }
}
