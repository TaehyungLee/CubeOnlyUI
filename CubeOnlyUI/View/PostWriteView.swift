//
//  PostWriteView.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/11/01.
//

import SwiftUI

class PostWriteViewModel:ObservableObject {
    @Published var titleTFStr:String = ""
    @Published var bodyHtmlStr:String = ""
    
    deinit {
        
    }
    
    init() {
        
    }
}

struct PostWriteView: View {
    
    @StateObject var vm = PostWriteViewModel()
        
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("포스트 쓰기")
                        .padding(.leading)
                    Spacer()
                }
                
                HStack {
                    TextField("제목", text: $vm.titleTFStr)
                        .padding()
                        .border(Color.init(white: 0.8))
                        .padding(.horizontal)
                }
                
                HStack {
                    Button {
                        
                    } label: {
                        ZStack {
                            Rectangle()
                                .fill(Color.gray)
                            Text("저장")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .frame(height: 44)
                        .cornerRadius(22)
                        
                    }
                    Button {
                        
                    } label: {
                        ZStack {
                            Rectangle()
                                .fill(Color.init(white: 0.80))
                            Text("아니오")
                                .font(.headline)
                                .foregroundColor(.white)
                                
                        }
                        .frame(height: 44)
                        .cornerRadius(22)
                    }
                }
                .padding(.horizontal)
            }
            
        }
    }
}

struct PostWriteView_Previews: PreviewProvider {
    static var previews: some View {
        PostWriteView()
    }
}
