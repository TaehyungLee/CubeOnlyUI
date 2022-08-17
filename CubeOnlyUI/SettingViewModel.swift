//
//  SettingViewModel.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/08/17.
//

import Foundation
import Combine

class SettingViewModel: ObservableObject {
    @Published var languageList = [
        "한국어",
        "영어",
        "중국어"
    ]
    
    @Published var alarmList = [
        "무음",
        "기본음향",
        "진동"
    ]
    
    init() {
        print("SettingViewModel")
    }
}
