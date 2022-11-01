//
//  KeyChainTestView.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/11/01.
//

import SwiftUI

class KeyChainTestViewModel:ObservableObject {
    @KeychainStorage("MyKey2") var savedValue = "Hello"
    @KeychainStorage("MyKey2") var savedValue2

    @Published var newValue = ""
    @Published var myKeyStr = ""
    @Published var myKey2Str = ""
}

struct KeyChainTestView: View {
    @StateObject var vm = KeyChainTestViewModel()
    var body: some View {
        VStack {
            TextField("MyValue", text: $vm.newValue)
                .padding()
            Button("Keychain Save") {
                vm.savedValue = vm.newValue
            }
            .padding()
            VStack {
                Text(vm.savedValue)
                    .padding()
                Text(vm.savedValue2)
                    .padding()
            }
            
        }
    }
}

struct KeyChainTestView_Previews: PreviewProvider {
    static var previews: some View {
        KeyChainTestView()
    }
}
