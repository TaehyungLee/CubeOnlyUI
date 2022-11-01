//
//  PhotoPicker.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/10/31.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var images: [UIImage]
    @Binding var videos: [URL]
//    @Binding var lives: [PHLivePhoto]
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: Context) -> some UIViewController {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
//        configuration.filter = .images // filter only to images
        configuration.filter = .any(of: [.images, .livePhotos, .videos])
        configuration.selectionLimit = 0 // ignore limit
        
        let photoPickerViewController = PHPickerViewController(configuration: configuration)
        photoPickerViewController.delegate = context.coordinator
        return photoPickerViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        private let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            DispatchQueue.main.async {
                self.parent.images.removeAll()
    //            parent.lives.removeAll()
                self.parent.videos.removeAll()
            }
            
            for result in results {
                let provider = result.itemProvider
                
                if provider.hasItemConformingToTypeIdentifier(UTType.movie.identifier) {
                    // video
                    provider.loadFileRepresentation(forTypeIdentifier: "public.movie") { url, error in
                        guard error == nil else {
                            print(error!.localizedDescription)
                            return
                        }
                        // receiving the video-local-URL / filepath
                        guard let url = url else {return}
                        // create a new filename
                        let fileName = "\(Int(Date().timeIntervalSince1970)).\(url.pathExtension)"
                        // create new URL
                        let newUrl = URL(fileURLWithPath: NSTemporaryDirectory() + fileName)
                        // copy item to APP Storage
                        try? FileManager.default.copyItem(at: url, to: newUrl)
                        DispatchQueue.main.async {
                            self.parent.videos.append(newUrl)
                        }
                        
                    }
                }
//                else if provider.canLoadObject(ofClass: PHLivePhoto.self) {
//                    // live photo
//                    let assetIdentifier = result.assetIdentifier
//                    if let phAsset = PHAsset.fetchAssets(withLocalIdentifiers: [assetIdentifier], options: nil).firstObject {
//                        PHImageManager.default().requestImageDataAndOrientation(for: phAsset, options: nil) { [weak self] data, _, _, _ in
//                            if let data = data, let image = UIImage(data: data) {
//                                self?.viewModel.imageBucket.append(image)
//                            }
//                        }
//                    }
//                }
                else if provider.canLoadObject(ofClass: UIImage.self) {
                    // photo
                    provider.loadObject(ofClass: UIImage.self) { [weak self] newImage, error in
                        if let error = error {
                            print("Can't load image \(error.localizedDescription)")
                        } else if let image = newImage as? UIImage {
                            DispatchQueue.main.async {
                                self?.parent.images.append(image)
                            }
                            
                        }
                    }
                } else {
                    print("Can't load asset")
                }
                
                
            }
            DispatchQueue.main.async {
                self.parent.isPresented = false
            }
            
        }
    }
}
