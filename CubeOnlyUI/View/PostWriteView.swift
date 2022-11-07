//
//  PostWriteView.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/11/01.
//

import SwiftUI
import RichEditorView

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
        
    @State private var htmlText = ""
    @State private var isEditingRichText = false
      
    var body: some View {
        VStack {
            VStack(spacing:0) {
                HStack {
                    Text("포스트 쓰기")
                        .padding()
                    Spacer()
                }
                
                HStack {
                    TextField("제목", text: $vm.titleTFStr)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 1)
                                .fill(Color.init(white: 0.8))
                        )
                        
                }
                .padding(.horizontal)
                
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 1)
                            .fill(Color.init(white: 0.8))
                        RichTextEditor(htmlText: $htmlText, isEditingRichText: $isEditingRichText)
                            .padding(.horizontal)
                            .padding(.vertical)
                            
                    }
                        
                }
                .padding()
                
                HStack(spacing:20) {
                    Button {
                        
                    } label: {
                        ZStack {
                            Capsule()
                                .fill(Color.init(white: 0.3))
                                .frame(width: 140, height: 45)
                            
                            Text("저장")
                                .foregroundColor(.white)
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        ZStack {
                            Capsule()
                                .fill(Color.init(white: 0.7))
                                .frame(width: 140, height: 45)
                            
                            Text("아니오")
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding()
            }
            
        }
    }
}

struct PostWriteView_Previews: PreviewProvider {
    static var previews: some View {
        PostWriteView()
    }
}
