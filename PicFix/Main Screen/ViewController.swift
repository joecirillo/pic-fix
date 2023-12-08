//
//  ViewController.swift
//  PicFix
//
//  Created by Joe Cirillo on 11/16/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class ViewController: UIViewController {
    let mainScreenView = MainScreenView()
    let childProgressView = ProgressSpinnerViewController()
    let database = Firestore.firestore()
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?
    let storage = Storage.storage()
    
    override func loadView(){
        view = mainScreenView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                //MARK: not signed in...
                //self.currentUser = nil
                self.mainScreenView.logInButton.addTarget(self, action: #selector(self.onLogInButtonTapped), for: .touchUpInside)
                self.mainScreenView.signUpButton.addTarget(self, action: #selector(self.onSignUpButtonTapped), for: .touchUpInside)
            } else {
                self.currentUser = user
                let photoSwipeViewController = PhotoSwipeViewController()
                photoSwipeViewController.currentUser = self.currentUser
                self.navigationController?.pushViewController(photoSwipeViewController, animated: true)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "PicFix"
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait // You can choose the orientation(s) you want to support
    }
}

