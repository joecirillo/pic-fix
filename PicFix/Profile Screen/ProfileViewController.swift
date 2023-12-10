//
//  ProfileScreenViewController.swift
//  PicFix
//
//  Created by Joe Cirillo on 11/27/23.
//

import UIKit
import PhotosUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage


class ProfileViewController: UIViewController {
    
    let childProgressView = ProgressSpinnerViewController()
    
    let profileScreen = ProfileView()
    
    let storage = Storage.storage()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?
    
    let notificationCenter = NotificationCenter.default
    
    var pickedPhoto:UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = profileScreen

        let customBarButtonItem = UIBarButtonItem(
            title: "Edit",
            style: .plain, // Adjust the style as needed (e.g., .plain, .done)
            target: self, // Set the target to the appropriate object
            action: #selector(onEditButtonTapped)
        )
        
        navigationItem.rightBarButtonItem = customBarButtonItem
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
            tapRecognizer.cancelsTouchesInView = false
            view.addGestureRecognizer(tapRecognizer)
        
        profileScreen.logOutButton.addTarget(self, action: #selector(onLogoutButtonTapped), for: .touchUpInside)
        
        notificationCenter.addObserver(
            self,
            selector: #selector(notificationReceivedForTextChanged(notification:)),
            name: Notification.Name("textFromSecondScreen"),
            object: nil)
    }
    
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
               // this would be if the user is signed out which is not a possible flow
            }else{
                //codes omitted...
                self.currentUser = user
//                
//                if let userEmail = self.currentUser?.email {
//                    self.profileScreen.updateEmailLabel(with: userEmail)
//                    print("Email Should Appear")
//                }

                //MARK: setting the profile photo...
                if let url = self.currentUser?.photoURL{
                    print("Photo Should Appear")
                    self.profileScreen.contactPhoto.loadRemoteImage(from: url)
                    self.profileScreen.name.text = user?.displayName
                    self.profileScreen.email.text = user?.email
                }
                
                //codes omitted...
                
            }
        }
    }
    
    @objc func onLogoutButtonTapped() {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    @objc func onEditButtonTapped() {
        let editProfileScreen = EditProfileViewController()
        navigationController?.pushViewController(editProfileScreen, animated: true)
    }
    
    @objc func notificationReceivedForTextChanged(notification: Notification){
    //    profileScreen.contactPhoto.image = (notification.object as! UIImage)
        self.pickedPhoto = (notification.object as! UIImage)
        uploadProfilePhotoToStorage()
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
