//
//  ViewController.swift
//  PicFix
//
//  Created by Joe Cirillo on 11/16/23.
//

import UIKit

class ViewController: UIViewController {
    let mainScreenView = MainScreenView()
    
    override func loadView(){
        view = mainScreenView
        
        mainScreenView.logInButton.addTarget(self, action: #selector(onLogInButtonTapped), for: .touchUpInside)
        
        mainScreenView.signUpButton.addTarget(self, action: #selector(onSignUpButtonTapped), for: .touchUpInside)
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "Messenger"
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    @objc func onLogInButtonTapped(){
        if let user = mainScreenView.userNameTextField.text,
           let password = mainScreenView.passwordTextField.text{
            if user.isEmpty {
                showEmptyErrorAlert()
            } else if password.isEmpty {
                showEmptyErrorAlert()
            } else {
                
            }
        }
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

