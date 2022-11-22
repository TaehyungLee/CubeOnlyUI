//
//  TextViewUI.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/11/14.
//

import SwiftUI
import TextView
import SDWebImageSwiftUI

struct TextViewUI: View {
    
    @State var tvStr:String = "naver url : \nhttp://m.naver.com"
    let urlStr = "http://iflow.skhynix.com/article/2607540"
    let description = "CUBE 개인CHANNELS 에 작성한 글중에 랜덤으로  삭제 표시가 안뜹니다."
//    let image = "http://iflow.skhynix.com/images/icons/open_graph_icon.png"
    let image = "https://plus.unsplash.com/premium_photo-1663051008566-c4227626f12e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80"
    let title = "CUBE 개인CHANNELS 글 삭제"
    
    var body: some View {
        VStack(spacing:0) {
            TextView($tvStr)
                .autoDetectDataTypes(.link)
                .isEditable(false)
                .placeholder("Input the text")
//                .padding(.leading)
//                .background(Color.gray.opacity(0.4))
                .padding(.horizontal, 10)
            
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 1)
                    .fill(Color.init(white: 0.8))
                VStack(alignment: .leading, spacing:0) {
                    WebImage(url: URL(string: image))
                        .resizable()
                        .indicator(.activity)
                        .scaledToFit()
                        .padding(.vertical, 8)
                    Text(title)
                        .font(.headline)
                    Text(description)
                        .font(Font.system(size: 14))
                        .foregroundColor(.gray)
                        .lineLimit(1)
                    Text(urlStr)
                        .font(Font.system(size: 14))
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.horizontal, 10)
            }
            .frame(height: 200)
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            
        }
    }
}

struct TextViewUI_Previews: PreviewProvider {
    static var previews: some View {
        TextViewUI()
    }
}
