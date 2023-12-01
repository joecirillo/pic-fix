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
        Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] (result, error) in
            guard let self = self else { return }
            //MARK: can you hide the progress indicator here?
            self.hideActivityIndicator()

            if error == nil {
                print("successfully logged in")
                //MARK: user authenticated...
                self.hideActivityIndicator()
                let photoSwipeViewController = PhotoSwipeViewController()
                //MARK: duplicated push
                self.navigationController?.pushViewController(photoSwipeViewController, animated: true)
            } else {
                print("Error signing in: \(error?.localizedDescription ?? "Unknown error")")
                showIncorrectErrorAlert()
                self.hideActivityIndicator()
            }
        })
    }
    
    @objc func onSignUpButtonTapped(){
        let createAccountViewController = CreateAccountViewController()
        self.navigationController?.pushViewController(createAccountViewController, animated: true)
    }
    
    func showEmptyErrorAlert(){
        let alert = UIAlertController(title: "Error", message: "Please fill in empty inputs", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    func showIncorrectErrorAlert(){
        let alert = UIAlertController(title: "Error", message: "Password or Email Incorrect", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
