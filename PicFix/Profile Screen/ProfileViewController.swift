//
//  ProfileScreenViewController.swift
//  PicFix
//
//  Created by Joe Cirillo on 11/27/23.
//

import UIKit
import FirebaseAuth


class ProfileViewController: UIViewController {
    
    let profileScreen = ProfileView()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?
    
    let notificationCenter = NotificationCenter.default

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
        
        profileScreen.logOutButton.addTarget(self, action: #selector(onLogoutButtonTapped), for: .touchUpInside)
        
        notificationCenter.addObserver(
            self,
            selector: #selector(notificationReceivedForTextChanged(notification:)),
            name: Notification.Name("textFromSecondScreen"),
            object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
               //codes omitted...
                print("aaaaaaaaaaaaa")
            }else{
                //codes omitted...
                print("wheohwfeoiewf")
                //MARK: setting the profile photo...
                if let url = self.currentUser?.photoURL{
                    print("hi")
                    self.profileScreen.contactPhoto.loadRemoteImage(from: url)
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
        profileScreen.contactPhoto.image = (notification.object as! UIImage)
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
