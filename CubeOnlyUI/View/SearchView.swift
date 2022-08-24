//
//  SearchView.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/08/17.
//

import SwiftUI

struct SearchTabModel:Identifiable {
    var id = UUID()
    var normalImgStr = ""
    var highlightImgStr = ""
}

struct SearchView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var searchStr = ""
    @State var tapIconImgList = [
        SearchTabModel(normalImgStr: "tab-at", highlightImgStr: "tab-at-on"),
        SearchTabModel(normalImgStr: "tab-star", highlightImgStr: "tab-star-on"),
        SearchTabModel(normalImgStr: "tab-mg", highlightImgStr: "tab-mg-on"),
        SearchTabModel(normalImgStr: "noti-ico-todo", highlightImgStr: "noti-ico-Highlighted-todo"),
        SearchTabModel(normalImgStr: "tab-file", highlightImgStr: "tab-file-on"),
        SearchTabModel(normalImgStr: "tab-post", highlightImgStr: "tab-post-on"),
        SearchTabModel(normalImgStr: "tab-pin", highlightImgStr: "tab-pin-on"),
        SearchTabModel(normalImgStr: "tab-member", highlightImgStr: "tab-member-on"),
        SearchTabModel(normalImgStr: "icon_like", highlightImgStr: "icon_like_on")
    ]
    @State private var selectedTab: UUID?
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Text("채널 개설")
                }
                HStack(spacing: 0) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Back")
                    }.padding()
                    Spacer()
                }
            }
            HStack {
                TextField("검색어 입력", text: $searchStr)
                
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing:40) {
                        ForEach(tapIconImgList) { item in
                            SearchTabItemView(imgStr: item.normalImgStr, imgHighlightStr: item.highlightImgStr, isSelected:(selectedTab == item.id)) {
                                selectedTab = item.id
                            }
                        }
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                Divider()
            }
            Spacer()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if let firstId = self.tapIconImgList.first?.id {
                selectedTab = firstId
            }
            
        }
    }
}


struct SearchTabItemView: View {
    
    var imgStr:String
    var imgHighlightStr:String
    var isSelected:Bool
    var action:()->Void
    var body: some View {
        ZStack {
            Button {
                action()
                
            } label: {
                Image(isSelected ? imgHighlightStr:imgStr)
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
            }

        }
    }
}
