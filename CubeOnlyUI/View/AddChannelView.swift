//
//  AddChannelView.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/08/17.
//

import SwiftUI
struct AddChannelView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var channelKorNameStr = ""
    @State var channelEngNameStr = ""
    @State var channelChnNameStr = ""
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Text("채널 개설")
                }
                HStack(spacing: 0) {
                    Spacer()
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Close")
                    }.padding()
                    
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                VStack(spacing: 0) {
                    VStack {
                        TextField("채널명(한국어)", text: $channelKorNameStr)
                        Divider()
                    }
                    VStack {
                        TextField("채널명(English)", text: $channelEngNameStr)
                        Divider()
                    }
                    VStack {
                        TextField("채널명(中国)", text: $channelChnNameStr)
                        Divider()
                    }
                }
            }
        }
        .background(Color.gray)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}
