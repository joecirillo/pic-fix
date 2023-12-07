//
//  AuthManager.swift
//  PicFix
//
//  Created by Christopher on 11/27/23.
//

import Foundation
import FirebaseAuth
import UIKit

extension ViewController {
    @objc func onLogInButtonTapped(){
        if let email = mainScreenView.emailTextField.text,
           let password = mainScreenView.passwordTextField.text{
            if email.isEmpty || password.isEmpty {
                showEmptyErrorAlert()
            } else {
                self.signInToFirebase(email: email, password: password)
            }
        }
    }
    
    func signInToFirebase(email: String, password: String){
        showActivityIndicator()
        //MARK: authenticating the user...
        Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
            if error == nil{
                print("successfully logged in")
                self.hideActivityIndicator()
                let photoSwipeViewController = PhotoSwipeViewController()
                //MARK: duplicated push
                //self.navigationController?.pushViewController(photoSwipeViewController, animated: true)
            }else{
                self.hideActivityIndicator()
                print(error)
                //MARK: alert that no user found or password wrong...
            }
            
        })
    }
    
    @objc func onSignUpButtonTapped(){
        let createAccountViewController = CreateAccountViewController()
        self.navigationController?.pushViewController(createAccountViewController, animated: true)
    }
    
    func showEmptyErrorAlert(){
        let alert = UIAlertController(title: "Error", message: "The inputs cannot be empty!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
