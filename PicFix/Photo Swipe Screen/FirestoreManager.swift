//
//  PhotoSwipeFirestoreManager.swift
//  PicFix
//
//  Created by Christopher on 11/30/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import PhotosUI
import Photos

extension PhotoSwipeViewController {
    func getImagePicker() -> UIMenu {
        var menuItems = [
            UIAction(title: "Gallery",handler: {(_) in
                self.uploadLocalPhotos()
            })
        ]
        
        return UIMenu(title: "Select source", children: menuItems)
    }
    
    func uploadLocalPhotos(){
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 6
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }
    
//    func uploadLocalPhotos2() {
//        // upload to storage
//        let fetchOptions = PHFetchOptions()
//        let result = PHAsset.fetchAssets(with: .image, options: fetchOptions)
//
//        for index in 0..<result.count {
//            let asset = result.object(at: index)
//            convertPHAssetToUIImage(asset: asset) { image in
//                if let image = image {
//                    self.uploadImageToFirebaseStorage(image: image)
//                }
//            }
//        }
//    }

//    func convertPHAssetToUIImage(asset: PHAsset, completion: @escaping (UIImage?) -> Void) {
//        let options = PHImageRequestOptions()
//        options.isSynchronous = true
//
//        PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 300, height: 400), contentMode: .aspectFit, options: options) { image, _ in
//            completion(image)
//        }
//    }
    
    //MARK: select images to upload
    func uploadImageToFirebaseStorage(images: [UIImage]) {
        for image in images {
            if let imageData = image.jpegData(compressionQuality: 0.4) {
                let storageRef = storage.reference()
                let imagesRepo = storageRef.child("images")
                let ref = imagesRepo.child("\(NSUUID().uuidString).jpg")
                
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpeg"
                
                let uploadTask = ref.putData(imageData, metadata: metadata) { (metadata, error) in
                    guard let metadata = metadata else {
                        return
                    }
                    ref.downloadURL { (url, error) in
                        if error != nil {
                            print(error.debugDescription)
                        } else {
                            if let downloadURL = url {
                                print(downloadURL)
                                self.uploadUrl(url: downloadURL)
                                self.urls.append(downloadURL)
                                if self.urls.count >= 6 {
                                    self.notificationCenter.post(
                                        name: Notification.Name("imagesUploaded"),
                                        object: nil)
                                }
                            }
                        }
                    }
                }
                uploadTask.observe(.progress) { snapshot in
                    guard let progress = snapshot.progress else { return }
                    let percentComplete = 100.0 * Double(progress.completedUnitCount) / Double(progress.totalUnitCount)
                    print("Upload progress: \(percentComplete)%")
                }
            }
        }
    }
    
    func uploadUrl(url: URL) {
        let db = Firestore.firestore()
        let collectionUrls = db.collection("users").document((self.currentUser?.email)!).collection("imageUrls")
        let imageUrl = ImageUrl(imageUrl: url)
        
        do{
            try collectionUrls.addDocument(from: imageUrl, completion: {(error) in
                if error == nil{
                    //self.navigationController?.popViewController(animated: true)
                    self.hideActivityIndicator()
                }
            })
        }catch{
            print("Error adding document!")
        }
    }
}
