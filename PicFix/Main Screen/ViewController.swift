//
//  ViewController.swift
//  PicFix
//
//  Created by Joe Cirillo on 11/16/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class ViewController: UIViewController {
    let mainScreenView = MainScreenView()
    let childProgressView = ProgressSpinnerViewController()
    let database = Firestore.firestore()
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?
    
    override func loadView(){
        view = mainScreenView
        //1111
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                //MARK: not signed in...
                self.currentUser = nil
                self.mainScreenView.logInButton.addTarget(self, action: #selector(self.onLogInButtonTapped), for: .touchUpInside)
                self.mainScreenView.signUpButton.addTarget(self, action: #selector(self.onSignUpButtonTapped), for: .touchUpInside)
            } else {
                let photoSwipeViewController = PhotoSwipeViewController()
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

