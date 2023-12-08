//
//  NewChatViewController.swift
//  Message App
//
//  Created by Christopher on 11/12/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class CreateAlbumViewController: UIViewController {
    var currentUser:FirebaseAuth.User?
    let database = Firestore.firestore()
    let childProgressView = ProgressSpinnerViewController()
    let createAlbumScreen = CreateAlbumView()
    
    override func loadView() {
        view = createAlbumScreen
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "Create a New Album"
        
        createAlbumScreen.buttonAdd.addTarget(self, action: #selector(onAddButtonTapped), for: .touchUpInside)
    }
    
    //MARK: on add button tapped....
    @objc func onAddButtonTapped(){
        if let name = createAlbumScreen.textFieldName.text?.lowercased(){
            
            if name == "" {
                //alert..
                showNameNotEnteredAlert()
            }
            else{
                // checks the users collection in Firestore to determine whether the email is a valid user
                checkNameExists(albumName: name)
                
                //MARK: need to get user from given email and set that as userChatting in new Chat
                //let friend = getFriendFromFirebase()
                //let chat = Chat(messages: [Message](), userChatting: friend)
                //saveChatToFireStore(chat: chat)
            }
        }
        
    }
    
    func checkNameExists(albumName documentID: String) {
        let db = Firestore.firestore()
        let documentRef = db.collection("users").document((currentUser?.email)!).collection("albums").document(documentID)

        documentRef.getDocument { (documentSnapshot, error) in
            if let error = error {
                print("Error getting document: \(error.localizedDescription)")
                return
            }

            if let documentSnapshot = documentSnapshot, documentSnapshot.exists {
                print("The document with ID \(documentID) exists.")
                self.showNameAlreadyExistsAlert()
            } else {
                print("The document with ID \(documentID) does not exist.")
                let album = Album(albumName: documentID)
                self.createAlbumInFirestore(album: album)
            }
        }
    }
    
    func createAlbumInFirestore(album: Album){
        if let userEmail = currentUser!.email{
            let collectionAlbums = database
                .collection("users")
                .document(userEmail)
                .collection("albums")
                .document(album.albumName!)
            showActivityIndicator()
            do{
                try collectionAlbums.setData(from: album, completion: {(error) in
                    if error == nil{
                        self.navigationController?.popViewController(animated: true)
                        self.hideActivityIndicator()
                    }
                })
            }catch{
                print("Error adding document!")
            }
        }
    }
}

extension CreateAlbumViewController:ProgressSpinnerDelegate{
    func showActivityIndicator(){
        addChild(childProgressView)
        view.addSubview(childProgressView.view)
        childProgressView.didMove(toParent: self)
    }
    
    func hideActivityIndicator(){
        childProgressView.willMove(toParent: nil)
        childProgressView.view.removeFromSuperview()
        childProgressView.removeFromParent()
    }
}
