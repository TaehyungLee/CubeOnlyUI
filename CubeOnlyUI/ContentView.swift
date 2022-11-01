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
        "투표설정"
    ]
    @Published var isExpandBottomMenu: Bool = false
    
    init() {
        
    }
    
}

struct ContentView: View {
    
    @StateObject var vm = ContentViewModel()
    
    var body: some View {
        
        NavigationView {
            ZStack {
                ScrollView {
                    VStack {
                        ForEach(vm.menuList.indices, id: \.self) { rowNum in
                            NavigationLink {
                                goNextMenu(rowNum: rowNum)
                            } label: {
                                VStack(spacing:0) {
                                    Text(vm.menuList[rowNum])
                                        .font(.headline)
                                        .padding()
                                    Divider()
                                }
                            }
                        }
                    }
                }
                // 하단 메뉴들
//                VStack {
//                    Spacer()
//                    BottomMenuView(isExpand: $vm.isExpandBottomMenu) {
//                        vm.isExpandBottomMenu.toggle()
////                        isExpandPublish.send(isExpandBottomMenu)
//                    }
//
//                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(.automatic)
            .onAppear {
                
            }
        }
        
    }
    
    func goNextMenu(rowNum:Int) -> some View {
        VStack {
            switch rowNum {
            case 0:
                KeyChainTestView()
            case 1:
                LocalImageGetView()
            case 2:
                SettingView()
            case 3:
                SearchView()
            case 4:
                PostWriteView()
            case 5:
                TransrateView()
            case 6:
                VotingWriteView()
            default:
                EmptyView()
            }
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
