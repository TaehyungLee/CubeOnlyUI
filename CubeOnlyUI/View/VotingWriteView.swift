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
                .padding()
        }
        .border(Color.init(white: 0.8))
        
    }
}

class VotingWriteViewModel:ObservableObject {
    @Published var titleStr = ""
    @Published var answerList:[AnswerModel] = []
    
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
    
}

struct VotingWriteView: View {
    @StateObject var vm = VotingWriteViewModel()
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                
                HStack(spacing:0) {
                    
                }
                .padding(.bottom, 20)
                VStack(spacing:0) {
                    VStack(spacing:11) {
                        TextField("제목을 입력하세요.", text: $vm.titleStr)
                        Divider()
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
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
                }
                VStack {
                    VotingCheckRowView(titleStr: "마감시간 설정") { isChecked in
                        if isChecked {
                            
                        } else {
                            
                        }
                    }
                }
                .padding()
                
                VStack {
                    VotingCheckRowView(titleStr: "복수 선택") { isChecked in
                        if isChecked {
                            
                        } else {
                            
                        }
                    }
                    VotingCheckRowView(titleStr: "선택항목 추가 허용") { isChecked in
                        if isChecked {
                            
                        } else {
                            
                        }
                    }
                    VotingCheckRowView(titleStr: "무기명") { isChecked in
                        if isChecked {
                            
                        } else {
                            
                        }
                    }
                }
                .padding()
                
            }
        }
        
    }
}

struct VotingWriteView_Previews: PreviewProvider {
    static var previews: some View {
        VotingWriteView()
    }
}
