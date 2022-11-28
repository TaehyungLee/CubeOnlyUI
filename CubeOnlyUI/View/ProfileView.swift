//
//  ProfileView.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/11/28.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileModel:Identifiable, Codable {
    var id = UUID().uuidString
    var name:String
    var email:String
    var dept:String
    var position:String
    var phoneNum:String
    var cellPhone:String
    var work:String
}

struct ProfileInfoRowView:View {
    let title:String
    let content:String
    var body: some View {
        VStack(alignment:.leading, spacing:0) {
            HStack(spacing: 0, content: {
                Text(title)
                    .font(.system(size: 15))
                    .frame(width: 90, alignment: .leading)
                Text(content)
                    .font(.system(size: 15))
                Spacer()
            })
            .padding(.vertical, 10)
            Divider()
        }
        .padding(.horizontal, 60)
    }
}

class ProfileViewModel:ObservableObject {
    
    @Published var profileInfoDic:[String:Any] = [:]
    let profileInfo = ProfileModel(name: "유하늘", email: "haneul.you@partner.sk.com", dept: "경영 운영", position: "과장", phoneNum: "", cellPhone: "010-2222-3333", work: "")
    let urlStr = "https://cubemobile.skhynix.com:9000/i/pf/I0101845"
    init() {
        
        guard let profileDic = profileInfo.toDictionary else { return }
        profileInfoDic = profileDic
    }
    
}

struct ProfileView: View {
    
    @Environment(\.presentationMode) var present
    
    @StateObject var vm = ProfileViewModel()
    
    var body: some View {
        VStack(spacing:0) {
            topNaviBar
                .frame(height: 55)
                .padding(.horizontal, 20)
                
            WebImage(url: URL(string: vm.urlStr))
                .resizable()
                .indicator(.activity)
                .scaledToFit()
                .frame(height: 300)
                .padding(.vertical, 15)
            detailInfoView
            bottomBtnView
                .padding(.vertical)
            Spacer()
            
        }
    }
    
    
    var topNaviBar:some View {
        ZStack {
            Text("User Information")
                .font(.headline)
            HStack {
                Button {
                    present.wrappedValue.dismiss()
                } label: {
                    Image("topnavi-back")
                        .resizable()
                        .frame(width: 12, height: 22)
                }
                Spacer()
                
            }
            
            
        }
    }
    
    var detailInfoView:some View {
        VStack(spacing:0) {
            ProfileInfoRowView(title: "이름", content: vm.profileInfo.name)
            ProfileInfoRowView(title: "부서", content: vm.profileInfo.dept)
            ProfileInfoRowView(title: "직급", content: vm.profileInfo.position)
            ProfileInfoRowView(title: "내선번호", content: vm.profileInfo.phoneNum)
            ProfileInfoRowView(title: "핸드폰번호", content: vm.profileInfo.cellPhone)
            ProfileInfoRowView(title: "E-mail", content: vm.profileInfo.email)
            ProfileInfoRowView(title: "담당업무", content: vm.profileInfo.work)
        }
    }
    
    var bottomBtnView:some View {
        HStack(spacing:20) {
            Button {
                
            } label: {
                ZStack {
                    Capsule()
                        .fill(Color.init(white: 0.6))
                        .frame(width: 140, height: 45)
                    
                    Text("대화하기")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }
            }
            
            Button {
                
            } label: {
                ZStack {
                    Capsule()
                        .fill(Color.init(white: 0.6))
                        .frame(width: 140, height: 45)
                    
                    Text("연락처 저장")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
