//
//  ContentView.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/08/17.
//

import SwiftUI
import Combine
struct MyType:Codable {
    var str:String = ""
}

struct ContentView: View {
    
    @State var showModal = false
    @State var showImagePicker: Bool = false
    
    @State var image: Image? = nil
    
    @State var newValue = ""
    @KeychainStorage("MyKey2") var savedValue = "Hello"
    @KeychainStorage("MyKey2") var savedValue2
    
//    var isExpandPublish = PassthroughSubject<Bool,Never>()
    @State var isExpandBottomMenu: Bool = false
    var body: some View {
        
        NavigationView {
            ZStack {
                VStack {
                    VStack(spacing:70) {
                        
                        TextField("MyValue", text: $newValue)
                            .padding()
                        Button("Keychain Save") {
                            savedValue = newValue
                        }
                        Text(savedValue)
                        Text(savedValue2)
                        Button {
                            showModal = true
                        } label: {
                            Text("검색화면")
                        }
                        .sheet(isPresented: $showModal, content: {
                            SearchView()
                        })
                        VStack {
                            Button {
                                showImagePicker = true
                            } label: {
                                Text("이미지피커")
                            }
                            .sheet(isPresented: $showImagePicker, content: {
//                                ImagePicker(sourceType: .photoLibrary) { image in
//                                    self.image = Image(uiImage: image)
//                                }
                                PhotoPickerView()
                            })
                            image?.resizable().frame(width: 100, height: 100)
                        }
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
                    Spacer()
                    BottomMenuView(isExpand: $isExpandBottomMenu) {
                        isExpandBottomMenu.toggle()
//                        isExpandPublish.send(isExpandBottomMenu)
                    }
                        
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(.automatic)
            .onAppear {
                
            }
        }
        
    }
    
    func keychainTest() {
        
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
