//
//  ipadMainView.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/12/12.
//

import SwiftUI

struct LeftSideMenuModel:Identifiable {
    let id = UUID().uuidString
    let imageNameStr:String
    var unreadCnt:Int
}

struct LeftSideMenuRowView: View {
    
    let model:LeftSideMenuModel
    
    var body:some View {
        ZStack {
            VStack(alignment:.leading) {
                Spacer()
                Image(model.imageNameStr)
                    .resizable()
                    .frame(width: 30, height: 29, alignment: .center)
                    .padding(.leading, 5)
                
            }
            if model.unreadCnt > 0 {
                HStack(alignment:.top) {
                    Spacer()
                    Text("\(model.unreadCnt)")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .padding(.all, 2)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(
                                    Color.red
                                )
                        )
                }
            }
            
        }
        .frame(width: 44, height: 44)
    }
}

class IpadMainViewModel:ObservableObject {
    @Published var leftMenuList:[LeftSideMenuModel] = []
    
    init() {
        leftMenuList = [
            LeftSideMenuModel(imageNameStr: "left_btn_chatting", unreadCnt: 10),
            LeftSideMenuModel(imageNameStr: "left_btn_alarm_enable", unreadCnt: 0),
            LeftSideMenuModel(imageNameStr: "left_btn_payment_enable", unreadCnt: 12),
            LeftSideMenuModel(imageNameStr: "left_btn_mail_enable", unreadCnt: 0),
            LeftSideMenuModel(imageNameStr: "left_btn_calender_enable", unreadCnt: 0),
            LeftSideMenuModel(imageNameStr: "left_btn_todo_enable", unreadCnt: 11),
            LeftSideMenuModel(imageNameStr: "noti-ico-visitor", unreadCnt: 15),
            LeftSideMenuModel(imageNameStr: "btn_hynixmap", unreadCnt: 0),
            LeftSideMenuModel(imageNameStr: "left_btn_meeting_enable", unreadCnt: 0),
            LeftSideMenuModel(imageNameStr: "left_btn_gyeongjosa_enable", unreadCnt: 0),
            LeftSideMenuModel(imageNameStr: "left_btn_visit_enable", unreadCnt: 0),
            LeftSideMenuModel(imageNameStr: "icon_setting", unreadCnt: 0),
            LeftSideMenuModel(imageNameStr: "channel-change", unreadCnt: 0)
        ]
    }
}

struct ipadMainView: View {
    
    let leftSideMenuWidth:CGFloat = 44
    let chDmListWidth:CGFloat = 180
    
    @StateObject var vm = IpadMainViewModel()
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                HStack {
                    leftMenuView
                    .frame(width: leftSideMenuWidth)
                    Divider()
                    VStack {
                        HStack(spacing:0) {
                            Text("cube")
                                .font(.system(size: 20))
                                .bold()
                                .foregroundColor(.black)
                                .padding(.trailing, 5)
                            Text("홍길동")
                                .font(.system(size: 15))
                                .foregroundColor(.init(white: 0.2))
                                .padding(.trailing, 5)
                            Text("기타 협력사")
                                .font(.system(size: 13))
                                .foregroundColor(.init(white: 0.3))
                            Spacer()
                        }
                        channelView
                        .frame(height: proxy.size.height/2)
                        dmView
                        .frame(height: proxy.size.height/2)
                        
                    }
                    .frame(width: chDmListWidth)
                    Divider()
                    chatView
                    .frame(width: proxy.size.width - leftSideMenuWidth - chDmListWidth)
                }
            }
            .navigationTitle("")
            .navigationBarBackButtonHidden()
            .navigationBarHidden(true)
        }
    }
    
    var leftMenuView:some View {
        VStack {
            Image("top_img_logo")
                .resizable()
                .frame(width: 24, height: 28, alignment: .center)
//                            .padding(.bottom, 10)
            
            ScrollView(.vertical) {
                VStack(spacing:5) {
                    ForEach(vm.leftMenuList, id: \.id) { model in
                        LeftSideMenuRowView(model: model)
                    }
                }
            }
        }
    }
    
    var channelView:some View {
        VStack(alignment: .leading) {
            VStack(spacing:0) {
                Text("Channels")
                    .font(.headline)
                    .padding(.bottom, 6)
                Divider()
                    .background(
                        Color.blue
                    )
                    .frame(height: 2)
            }
            .frame(width: 90)
            ScrollView {
                
            }
            
        }
    }
    
    var dmView:some View {
        VStack(alignment: .leading) {
            VStack(spacing:0) {
                Text("Messages")
                    .font(.headline)
                    .padding(.bottom, 6)
                
            }
            .frame(width: 90)
            ScrollView {
                
            }
        }
    }
    
    var chatView:some View {
        VStack {
            
        }
        .background(
            Color.red
        )
    }
}

struct ipadMainView_Previews: PreviewProvider {
    static var previews: some View {
        ipadMainView()
    }
}
