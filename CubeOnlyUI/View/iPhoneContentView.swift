//
//  iPhoneContentView.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/12/12.
//

import SwiftUI

struct iPhoneContentView: View {
    @StateObject var vm = ContentViewModel()
    var body: some View {
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
        .navigationTitle("iPhone UI")
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
            case 7:
                TextViewUI()
            case 8:
                ScrollViewTest()
            default:
                EmptyView()
            }
        }
        
    }
    
}

struct iPhoneContentView_Previews: PreviewProvider {
    static var previews: some View {
        iPhoneContentView()
    }
}
