//
//  SettingView.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/08/17.
//

import SwiftUI

enum ActionSheetOption {
    case languageMode
    case alarmMode
}

struct SettingView: View {
    
    @StateObject var settingVM = SettingViewModel()
    
    @State var languageStr = ""
    @State var recvMsgTransLangStr = ""
    @State var msgInputTransLangStr = ""
    @State var alarmSoundStr = ""
    
    @State var channelReplyAlarmOnOff = false
    @State var channelMessageAlarmOnOff = false
    @State var dmMessageAlarmOnOff = false
    
    @State var actionSheetOption: ActionSheetOption = .languageMode
    
    @State var showLanguageActionSheet = false
    @State var showAlarmActionSheet = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                ZStack {
                    HStack {
                        Text("설정")
                    }
                    HStack {
                        
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Back")
                        }
                        Spacer()
                    }
                }
                SelectMenuView(titleStr: "언어선택", valueStr: $languageStr) {
                    actionSheetOption = .languageMode
                    self.showLanguageActionSheet = true
                }
                    .padding(.top)
                    .actionSheet(isPresented: $showLanguageActionSheet, content: getActionSheet)
                SelectMenuView(titleStr: "받은메시지 번역언어 설정", valueStr: $recvMsgTransLangStr) {
                    
                }
                    .padding(.top)
                SelectMenuView(titleStr: "메시지 입력창 번역언어 설정", valueStr: $msgInputTransLangStr) {
                    
                }
                SelectMenuView(titleStr: "알림소리 설정", valueStr: $alarmSoundStr) {
                    actionSheetOption = .alarmMode
                    self.showAlarmActionSheet = true
                }
                .actionSheet(isPresented: $showAlarmActionSheet, content: getActionSheet)
            }
            .padding(EdgeInsets(top: 20, leading: 15, bottom: 10, trailing: 15))
            VStack(spacing: 0) {
                HStack {
                    Text("채널 알림 설정")
                    Spacer()
                }
                CheckMenuView(imageStr: "myset-reply", titleStr: "댓글", isChecked: $channelReplyAlarmOnOff) {
                    channelReplyAlarmOnOff.toggle()
                }
                CheckMenuView(imageStr: "myset-msg", titleStr: "메시지", isChecked: $channelMessageAlarmOnOff) {
                    channelMessageAlarmOnOff.toggle()
                }
            }
            .padding(EdgeInsets(top: 20, leading: 15, bottom: 10, trailing: 15))
            VStack(spacing: 0) {
                HStack {
                    Text("메시지")
                    Spacer()
                }
                CheckMenuView(imageStr: "myset-msg", titleStr: "메시지", isChecked: $dmMessageAlarmOnOff) {
                    dmMessageAlarmOnOff.toggle()
                }
            }
            .padding(EdgeInsets(top: 20, leading: 15, bottom: 10, trailing: 15))
            Spacer()
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            languageStr = settingVM.languageList.first ?? ""
            alarmSoundStr = settingVM.alarmList.first ?? ""
        }
        
    }
    
    func getActionSheet() -> ActionSheet {
        
        switch actionSheetOption {
        case .alarmMode:
            return ActionSheet(title: Text(""),
                               message: nil,
                               buttons: self.makeActionSheetButton(list: self.settingVM.alarmList, action: { str in
                self.alarmSoundStr = str
            }))
            
        case .languageMode:
            return ActionSheet(title: Text(""),
                               message: nil,
                               buttons: self.makeActionSheetButton(list: self.settingVM.languageList, action: { str in
                self.languageStr = str
            }))
        }
    }
    
    func makeActionSheetButton(list:[String], action:@escaping (String)->Void) -> [ActionSheet.Button] {
        
        var resultList:[ActionSheet.Button] = []
        for str in list {
            let acb: ActionSheet.Button = .default(Text(str)) {
                action(str)
            }
            resultList.append(acb)
            
        }
        let cancleButton: ActionSheet.Button = .cancel()
        resultList.append(cancleButton)
        return resultList
    }
}
