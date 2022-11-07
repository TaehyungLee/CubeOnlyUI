//
//  VotingWriteView.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/11/01.
//

import SwiftUI

struct AnswerModel:Identifiable {
    var id = UUID().uuidString
    var answerStr = ""
}

struct VotingCheckRowView: View {
    
    var titleStr:String
    var checkAction:(Bool)->Void
    
    @State var checked:Bool = false
    var body: some View {
        VStack {
            HStack {
                Text(titleStr)
                Spacer()
                Button {
                    checked.toggle()
                    checkAction(checked)
                } label: {
                    Image( checked ? "invite-check-on":"invite-check-off" )
                        .resizable()
                        .frame(width: 30, height: 30)
                }

            }
            Divider()
        }
        
    }
}

struct VotingAnswerRowView: View {
    @Binding var answer:AnswerModel
    
    var body: some View {
        VStack {
            TextField("항목입력", text: $answer.answerStr)
                .padding(.all, 12)
        }
        .border(Color.init(white: 0.8))
        
    }
}

class VotingWriteViewModel:ObservableObject {
    @Published var titleStr = ""
    @Published var answerList:[AnswerModel] = []
    
    @Published var isVotingMode = true
    @Published var isDeadline = false
    
    init() {
        answerList = [
            AnswerModel(answerStr: ""),
            AnswerModel(answerStr: ""),
            AnswerModel(answerStr: ""),
            AnswerModel(answerStr: ""),
            AnswerModel(answerStr: "")
        ]
    }
    
    func addAnswer() {
        answerList.append(AnswerModel(answerStr: ""))
    }
    
    func printAnswer() {
        for answer in self.answerList {
            print("answer : \(answer.answerStr)")
        }
    }
    
}

struct VotingWriteView: View {
    @StateObject var vm = VotingWriteViewModel()
    @Environment(\.presentationMode) var presentMode
    
    
    var body: some View {
        ZStack {
            // background
            Color.init(white: 0.90).ignoresSafeArea()
            VStack {
                
                HStack {
                    Button {
                        vm.isVotingMode = true
                    } label: {
                        Text("투표하기")
                            .foregroundColor(vm.isVotingMode ? .red:.black)
                    }
                    .buttonStyle(.plain)
                    .frame(width: UIScreen.main.bounds.size.width/2, height: 55)
                    
                    Button {
                        vm.isVotingMode = false
                    } label: {
                        Text("의견취합")
                            .foregroundColor(vm.isVotingMode ? .black:.red)
                    }
                    .buttonStyle(.plain)
                    .frame(width: UIScreen.main.bounds.size.width/2, height: 55)
                }
                .background(Color.white)
                ScrollView(showsIndicators: false) {
                    VStack {
                        
                        HStack(spacing:0) {
                            
                        }
                        .padding(.bottom, 5)
                        VStack(spacing:0) {
                            VStack(spacing:11) {
                                TextField("제목을 입력하세요.", text: $vm.titleStr)
                                Divider()
                            }
                            .padding()
                            if vm.isVotingMode {
                                ForEach(vm.answerList.indices, id: \.self) { idx in
                                    VotingAnswerRowView(answer: $vm.answerList[idx])
                                        .padding(.horizontal)
                                        .padding(.bottom)
                                }
                                HStack {
                                    Button {
                                        vm.addAnswer()
                                    } label: {
                                        HStack {
                                            Spacer()
                                            Text("+ 항목추가")
                                                .padding()
                                            Spacer()
                                        }
                                        
                                    }

                                }
                                .border(.blue)
                                .padding(.horizontal)
                                .padding(.bottom)
                            }
                            
                        }
                        .background(Color.white)
                        .padding(.bottom, 5)
                        
                        VStack(spacing:0) {
                            VotingCheckRowView(titleStr: "마감시간 설정") { isChecked in
                                vm.isDeadline = isChecked
                                if isChecked {
                                    
                                } else {
                                    
                                }
                            }
                            
                            if vm.isDeadline {
                                Button {
                                    
                                } label: {
                                    HStack {
                                        Text("마감시간을 선택해 주세요.")
                                            .padding(.vertical)
                                        Spacer()
                                    }
                                }
                                .buttonStyle(.plain)
                            }
                            
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        .background(Color.white)
                        .padding(.bottom, 5)
                        
                        VStack {
                            VotingCheckRowView(titleStr: "복수 선택") { isChecked in
                                if isChecked {
                                    
                                } else {
                                    
                                }
                            }
                            if vm.isVotingMode {
                                VotingCheckRowView(titleStr: "선택항목 추가 허용") { isChecked in
                                    if isChecked {
                                        
                                    } else {
                                        
                                    }
                                }
                                
                            }
                            VotingCheckRowView(titleStr: "무기명") { isChecked in
                                if isChecked {
                                    vm.isDeadline = true
                                } else {
                                    
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        .background(Color.white)
                        
                        HStack(spacing:20) {
                            Button {
                                vm.printAnswer()
                            } label: {
                                ZStack {
                                    Capsule()
                                        .fill(Color.init(white: 0.3))
                                        .frame(width: 140, height: 45)
                                    
                                    Text("확인")
                                        .foregroundColor(.white)
                                }
                            }
                            
                            Button {
                                
                            } label: {
                                ZStack {
                                    Capsule()
                                        .fill(Color.init(white: 0.7))
                                        .frame(width: 140, height: 45)
                                    
                                    Text("취소")
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle(vm.isVotingMode ? "투표 설정":"의견 취합")
            
        }
        
        
    }
}

struct VotingWriteView_Previews: PreviewProvider {
    static var previews: some View {
        VotingWriteView()
    }
}
