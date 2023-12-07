//
//  PhotoSwipeFirestoreManager.swift
//  PicFix
//
//  Created by Christopher on 11/30/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

extension PhotoSwipeViewController {
    func checkFilePathExists(filePath: String) -> Bool? {
        let collectionFilePaths = self.database.collection("photoUrl")
        var fileExists: Bool = true
        collectionFilePaths.whereField("photoUrl", isEqualTo: filePath).getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            fileExists = !documents.isEmpty
        }
        return fileExists
    }
    
    func saveFilePath(filePath: String) {
        if let userEmail = currentUser!.email{
            let collectionPhotoUrls = self.database.collection("users").document(userEmail).collection("albums")
            let photo = PhotoUrl(photoUrl: filePath)
            
            do {
                try collectionPhotoUrls.addDocument(from: photo, completion: {(error) in
                    //self.filePaths.append(photo) //MARK: might not need this
                    print("Document added for photo")})
            } catch {
                print("Error adding document!")
            }
        }
    }
    

}
