//
//  iPadContentView.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/12/12.
//

import SwiftUI

struct iPadContentView: View {
    @StateObject var vm = ContentViewModel()
    var body: some View {
        ipadMainView()
    }
    
}

struct iPadContentView_Previews: PreviewProvider {
    static var previews: some View {
        iPadContentView()
    }
}
