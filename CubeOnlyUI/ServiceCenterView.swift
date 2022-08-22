//
//  ServiceCenterView.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/08/22.
//

import SwiftUI

enum HynixCampus {
    case icheon, chungju, bundang
}

struct CampusTapView: View {
    var campusValue:HynixCampus
    @Binding var selectedCampusValue:HynixCampus
    var action:()->Void
    var titleStr:String {
        switch campusValue {
        case .icheon:
            return "이천"
        case .chungju:
            return "청주"
        case .bundang:
            return "분당"
        }
    }
    
    var lineHeight:CGFloat {
        return (campusValue == selectedCampusValue) ? 2:0.5
    }
    
    var textColor:Color {
        return (campusValue == selectedCampusValue) ? .orange:.black
    }
    
    var lineColor:Color {
        return (campusValue == selectedCampusValue) ? .orange:Color(uiColor: .lightGray)
    }
    var body: some View {
        VStack(spacing: 0) {
            Button {
                self.action()
            } label: {
                Text(titleStr)
                    .foregroundColor(textColor)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(Color.white)
            }
            .buttonStyle(.plain)
            Divider()
                .frame(height: lineHeight)
                .background(lineColor)
        }
    }
}

struct ServiceCenterView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var campusValue:HynixCampus = .icheon
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Text("사원 서비스 센터")
                }
                HStack(spacing: 0) {
                    Spacer()
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Close")
                    }.padding()
                    
                }
            }
            Divider()
                .background(Color.gray)
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    CampusTapView(campusValue: .icheon, selectedCampusValue: $campusValue) {
                        campusValue = .icheon
                    }
                    Divider()
                        .background(Color.gray)
                    CampusTapView(campusValue: .chungju, selectedCampusValue: $campusValue) {
                        campusValue = .chungju
                    }
                    Divider()
                        .background(Color.gray)
                    CampusTapView(campusValue: .bundang, selectedCampusValue: $campusValue) {
                        campusValue = .bundang
                    }
                }
                .frame(height: 50)
            }
            Divider()
                .background(Color.gray)
            ScrollView(.horizontal, showsIndicators: false) {
                VStack(spacing: 0) {
                    
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}
