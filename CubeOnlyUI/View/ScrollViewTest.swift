//
//  ScrollViewTest.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/11/21.
//

import SwiftUI


extension String {
    static func createRandomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String(
            (0..<length)
                .map { _ in letters.randomElement()! }
        )
    }
}

struct RandomModel:Identifiable {
    var id = UUID().uuidString
    var randomStr:String
}

enum RequestType {
    case prev
    case next
}

class ScrollViewTestViewModel:ObservableObject {
    
    @Published var isLoading = false
    @Published var list:[RandomModel] = []
    @Published var scrollToTarget:String? = nil
    let pagingNum = 15
    let maxPage = 3
    @Published var currPageNum = 1
    
    @Published var reqType:RequestType = .next
    
    init() {
        getNextData()
    }
    
    private func createDemoArray() -> [RandomModel] {
        var resultList:[RandomModel] = []
        for i in 0..<pagingNum {
//            resultList.append(RandomModel(randomStr: .createRandomString(length: 8)))
            resultList.append(RandomModel(randomStr: "\((currPageNum*pagingNum)+i)"))
        }
        return resultList
    }
    
    func getPrevData() {
        if currPageNum-1 >= 0 {
            
            self.reqType = .prev
            self.isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                self.currPageNum -= 1
                let arr = self.createDemoArray()
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.scrollToTarget = self.list.first?.id
                    self.list.insert(contentsOf: arr, at: 0)
                    
                }
                
            }
        }
        
    }
    
    func getNextData() {
        if maxPage >= currPageNum+1 {
            self.reqType = .next
            self.isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                self.currPageNum += 1
                let arr = self.createDemoArray()
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.list.append(contentsOf: arr)
                    self.scrollToTarget = self.list.last?.id
                }
                
            }
        }
        
        
    }
    
    
}

struct RandomRowView: View {
    let titleStr:String
    var body: some View {
        VStack(spacing:0) {
            Text(titleStr)
                .padding(.vertical, 40)
            Divider()
                .padding(.horizontal)
        }
    }
}

struct ScrollViewTest: View {
    @StateObject var vm = ScrollViewTestViewModel()
    var body: some View {
        ZStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack {
                        ForEach(vm.list) { model in
                            RandomRowView(titleStr: model.randomStr)
                                .id(model.id)
                                .onAppear {
                                    if vm.list.last?.id == model.id {
                                        vm.getNextData()
                                    }
                                    else if vm.list.first?.id == model.id {
                                        vm.getPrevData()
                                    }
                                }
                                .onTapGesture {
                                    withAnimation {
                                        proxy.scrollTo(model.id, anchor: .top)
                                    }
                                    
                                }
                        }
                    }
                    .onChange(of: vm.scrollToTarget) { (target) in
                        print(target ?? "")
                        withAnimation {
                            proxy.scrollTo(target, anchor: vm.reqType == .prev ? .top : .bottom)
                        }
                        
                    }
                    
                }
            }
            
            
            if vm.isLoading {
                
                ProgressView(label: {
                    Text("Loading..")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.bottom)
                })
                .padding(.top)
                .background(
                    RoundedRectangle(cornerRadius: 5).fill(Color.init(white: 0.8))
                )
                    
            }
            
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct ScrollViewTest_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewTest()
    }
}
