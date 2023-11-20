//
//  CreateAccountViewController.swift
//  PicFix
//
//  Created by Joe Cirillo on 11/20/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class CreateAccountViewController: UIViewController {
    let createAccountScreenView = CreateAccountScreenView()
    
    let storage = Storage.storage()
    
    let childProgressView = ProgressSpinnerViewController()
    
    override func loadView() {
        view = createAccountScreenView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        createAccountScreenView.createAccountButton.addTarget(self, action: #selector(onRegisterTapped), for: .touchUpInside)
        title = "Register"
    }
    
    @objc func onRegisterTapped(){
        //MARK: creating a new user on Firebase...
        if (doPasswordsMatch()) {
            showActivityIndicator()
            registerUser()
        }
        else {
            // implement error alert here
            print("passwords don't match")
        }
    }
    
    func doPasswordsMatch() -> Bool{
        if let password = createAccountScreenView.passwordTextField.text,
           let passwordConfirm = createAccountScreenView.passwordConfirmTextField.text {
            if (password == passwordConfirm && !password.isEmpty) {
                return true
            }
            else {
                return false
            }
        }
        return false
    }

}
