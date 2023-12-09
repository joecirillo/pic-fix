//
//  ProfileFirebaseManager.swift
//  PicFix
//
//  Created by Joe Cirillo on 12/8/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

extension ProfileViewController {

    
    func uploadProfilePhotoToStorage(){
        var profilePhotoURL:URL?
        
        //MARK: Upload the profile photo if there is any...
        if let image = pickedPhoto{
            if let jpegData = image.jpegData(compressionQuality: 80){
                let storageRef = storage.reference()
                let imagesRepo = storageRef.child("imagesUsers")
                let imageRef = imagesRepo.child("\(NSUUID().uuidString).jpg")
                
                let uploadTask = imageRef.putData(jpegData, completion: {(metadata, error) in
                    if error == nil{
                        imageRef.downloadURL(completion: {(url, error) in
                            if error == nil{
                                profilePhotoURL = url
                                self.showActivityIndicator()
                                self.setPhotoOfTheUserInFirebaseAuth(photoURL: profilePhotoURL)
                            }
                        })
                    }
                })
            }
        }
    }
    
    
    func setPhotoOfTheUserInFirebaseAuth(photoURL: URL?){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.photoURL = photoURL
        
        print("\(photoURL)")
        changeRequest?.commitChanges(completion: {(error) in
            if error != nil{
                print("Error occured: \(String(describing: error))")
            }else{
                self.hideActivityIndicator()
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
}
