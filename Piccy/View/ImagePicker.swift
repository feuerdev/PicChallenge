//
//  ImagePicker.swift
//  Piccy
//
//  Created by Jannik Feuerhahn on 12.05.21.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool // close the modal view
    var vm:Pickable
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = 0
        config.filter = .any(of: [.images, .livePhotos])
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        //not needed
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            for image in results {
                print("---")
                print(image.itemProvider.suggestedName)
                if image.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    image.itemProvider.loadObject(ofClass: UIImage.self) { newImage, error in
                        print("loaded")
                        if let error = error {
                            print("error")
//                            print("Can't load image \(error.localizedDescription)")
                        } else if let image = newImage as? UIImage {
                            DispatchQueue.main.async {
                                self.parent.vm.pickedPhoto(image)
                            }
                        } else {
                            print("couldnt create UIImage")
                        }
                    }
                } else {
                    print("Can't load asset")
                }
            }
            parent.isPresented = false
        }
    }
}
