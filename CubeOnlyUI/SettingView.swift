//
//  SettingView.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/08/17.
//

import SwiftUI

struct SettingView: View {
    
    @State var languageStr = ""
    @State var recvMsgTransLangStr = ""
    @State var msgInputTransLangStr = ""
    @State var alarmSoundStr = ""
    
    @State var channelReplyAlarmOnOff = false
    @State var channelMessageAlarmOnOff = false
    @State var dmMessageAlarmOnOff = false
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack {
                    Text("설정")
                }
                SelectMenuView(titleStr: "언어선택", valueStr: $languageStr) {
                    
                }
                    .padding(.top)
                SelectMenuView(titleStr: "받은메시지 번역언어 설정", valueStr: $recvMsgTransLangStr) {
                    
                }
                    .padding(.top)
                SelectMenuView(titleStr: "메시지 입력창 번역언어 설정", valueStr: $msgInputTransLangStr) {
                    
                }
                SelectMenuView(titleStr: "알림소리 설정", valueStr: $alarmSoundStr) {
                    
                }
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
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
