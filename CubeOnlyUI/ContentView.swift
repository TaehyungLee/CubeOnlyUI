//
//  ContentView.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/08/17.
//

import SwiftUI

struct ContentView: View {
    
    @State var showModal = false
    var body: some View {
        
        NavigationView {
            ZStack {
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing:70) {
                            Button {
                                showModal = true
                            } label: {
                                Text("서비스센터")
                            }
                            .sheet(isPresented: $showModal, content: {
                                ServiceCenterView()
                            })
                            Button {
                                
                            } label: {
                                Text("테스트버튼")
                            }
                            Button {
                                
                            } label: {
                                Text("테스트버튼")
                            }
                            Button {
                                
                            } label: {
                                Text("테스트버튼")
                            }
                            Button {
                                
                            } label: {
                                Text("테스트버튼")
                            }
                            Button {
                                
                            } label: {
                                Text("테스트버튼")
                            }
        //                    .fullScreenCover(isPresented: $showModal, content: {
        //
        //                    })
                            NavigationLink {
                                SettingView()
                            } label: {
                                Text("Setting")
                            }
                            .padding()
                            NavigationLink {
                                SearchView()
                            } label: {
                                Text("Search")
                            }
                            .padding()
                            
                        }
                    }
                    // 하단 메뉴들
                    VStack {
                        BottomMenuView()
                            
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(.automatic)
        }
        
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
