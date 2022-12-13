//
//  ContentView.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/08/17.
//

import SwiftUI
import Combine
import Photos

struct MyType:Codable {
    var str:String = ""
}

class ContentViewModel:ObservableObject {
    
    @Published var menuList = [
        "키체인 테스트",
        "이미지 피커",
        "세팅",
        "서치",
        "포스트작성",
        "번역",
        "투표설정",
        "링크",
        "스크롤"
    ]
    @Published var isExpandBottomMenu: Bool = false
    
    init() {
        
    }
    
}

struct ContentView: View {
    
    var body: some View {
        
        NavigationView {
            VStack {
                if UIDevice.current.isiPhone {
                    NavigationLink {
                        iPhoneContentView()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1)
                                .fill(
                                    Color.gray
                                )
                            Text("iPhone View")
                                .font(.headline)
                        }
                        .frame(width: 180, height: 50)
                    }
                }
                else{
                    NavigationLink {
                        iPadContentView()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1)
                                .fill(
                                    Color.gray
                                )
                            Text("iPad View")
                                .font(.headline)
                        }
                        .frame(width: 180, height: 50)
                    }
                }
                
                
            }
            .navigationBarTitle("큐브 UI")
            .navigationBarTitleDisplayMode(.large)
            .navigationViewStyle(.automatic)
            .onAppear {
                
            }
        }
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
