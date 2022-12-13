//
//  CommonViewModel.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/12/12.
//

import SwiftUI
import Combine

class CommonViewModel: ObservableObject {
    private var cancelBag = Set<AnyCancellable>()
    
    let webviewScriptStr = CurrentValueSubject<String, Never>("")
    
    init() {
        
    }
}
