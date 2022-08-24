//
//  BottomMenuView.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/08/22.
//

import SwiftUI
import Combine

struct BottomMenuView: View {
    var btmMenuList:[[String]] = [
        [
            "noti-ico-sign",
            "noti-ico-mail",
            "noti-ico-schdule",
            "noti-ico-todo",
            "noti-ico-visitor"
        ],
        [
            "noti-ico-meeting",
            "noti-ico-praising",
            "notilist-ico-confirm",
            "mobileHR",
            "notilist-ico-dict"
        ],
        [
            "emergency_icon9999_red",
            "she_safety",
            "btn_hynixmap",
            "notilist-ico-appraisal",
            ""
        ]
    ]
    
    @Binding var isExpand:Bool
    let action:()->Void
    var body: some View {
        VStack(spacing:0) {
            BottomMenuToggleView() {
                withAnimation {
                    action()
                }
            }
                .frame(height: 30)
                .background(Color(white: 0.95))
            List {
                ForEach(self.btmMenuList.filter { list in
                    return (isExpand || self.btmMenuList.first == list)
                }, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { item in
                            BottomMenuItemView(imgStr: item, isEnable: true, badgeCount: 0) {
                                
                            }
                            .frame(height: 45)
                        }
                    }
                }
            }
            .listStyle(.plain)
        }
        .frame(height: isExpand ? 180:75, alignment: .center)
        
    }
}
