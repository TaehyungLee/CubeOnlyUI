//
//  LocalImageGetView.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/11/01.
//

import SwiftUI

class LocalImageGetViewModel:ObservableObject {
    @Published var showActionsheet: Bool = false
    @Published var showImagePicker: Bool = false
    @Published var showCameraPicker: Bool = false
    @Published var showMoviePicker: Bool = false
    
    @Published var images: [UIImage] = []
    @Published var videos: [URL] = []
//    @Published var lives: [PHLivePhoto] = []
    
    init() {
        
    }
}

struct LocalImageGetView: View {
    @StateObject var vm = LocalImageGetViewModel()
    var body: some View {
        VStack {
            Button {
                vm.showActionsheet = true
            } label: {
                Text("이미지피커")
            }
            .sheet(isPresented: $vm.showImagePicker, content: {
                PhotoPicker(images: $vm.images,
                            videos: $vm.videos,
//                                            lives: $vm.lives,
                            isPresented: $vm.showImagePicker)
            })
            .sheet(isPresented: $vm.showCameraPicker, content: {
                ImagePicker(sourceType: .camera) { img in
                    vm.images.append(img)
                }
            })
            .actionSheet(isPresented: $vm.showActionsheet) {
                
                ActionSheet(title: Text(""), buttons: [
                    
                    .default(Text("사진(카메라 촬영)"), action: {
                        vm.showCameraPicker = true
                    }),
                    .default(Text("사진/동영상(앨범에서 선택)"), action: {
                        vm.showImagePicker = true
                    })
                ])
                
            }
            
            if vm.images.count > 0 {
                VStack {
                    Text("Images")
                        .font(.largeTitle)
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(vm.images, id:\.self) { uiimage in
                                Image(uiImage: uiimage)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                
            }
            if vm.videos.count > 0 {
                VStack {
                    Text("Videos")
                        .font(.largeTitle)
                    ScrollView(.vertical) {
                        VStack {
                            ForEach(vm.videos, id:\.self) { url in
                                Text(url.absoluteString)
                                    .font(.headline)
                                    .padding(.bottom, 10)
                            }
                        }
                    }
                }
                .frame(height: 200)
            }
            
        }
    }
}

struct LocalImageGetView_Previews: PreviewProvider {
    static var previews: some View {
        LocalImageGetView()
    }
}
