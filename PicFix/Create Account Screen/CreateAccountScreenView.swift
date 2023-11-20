//
//  CreateAccountScreenView.swift
//  PicFix
//
//  Created by Joe Cirillo on 11/20/23.
//

import UIKit

class CreateAccountScreenView: UIView {
    var scrollView = UIScrollView()
    var userNameTextField = UITextField()
    var userEmailTextField: UITextField!
    var passwordTextField = UITextField()
    var passwordConfirmTextField = UITextField()
    var createAccountButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        
        setupScrollView()
        setupUserEmail()
        setupUserName()
        passwordConfirm()
        setupPassword()
        setupCreateAccountButton()
        
        initConstrains()
    }
    
    func setupScrollView(){
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
    }
    func setupUserName(){
        userNameTextField = UITextField()
        userNameTextField.placeholder = "Name"
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.borderStyle = .roundedRect
        userNameTextField.layer.borderColor = UIColor.gray.cgColor
        userNameTextField.layer.cornerRadius = 10.0
        userNameTextField.layer.borderWidth = 1.0
        scrollView.addSubview(userNameTextField)
    }
    func setupUserEmail(){
        userEmailTextField = UITextField()
        userEmailTextField.placeholder = "Email"
        userEmailTextField.translatesAutoresizingMaskIntoConstraints = false
        userEmailTextField.borderStyle = .roundedRect
        userEmailTextField.layer.borderColor = UIColor.gray.cgColor
        userEmailTextField.layer.cornerRadius = 10.0
        userEmailTextField.layer.borderWidth = 1.0
        scrollView.addSubview(userEmailTextField)
    }
    func setupPassword(){
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.layer.borderColor = UIColor.gray.cgColor
        passwordTextField.layer.cornerRadius = 10.0
        passwordTextField.layer.borderWidth = 1.0
        scrollView.addSubview(passwordTextField)
    }
    func passwordConfirm(){
        passwordConfirmTextField = UITextField()
        passwordConfirmTextField.placeholder = "Retype Password"
        passwordConfirmTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordConfirmTextField.borderStyle = .roundedRect
        passwordConfirmTextField.layer.borderColor = UIColor.gray.cgColor
        passwordConfirmTextField.layer.cornerRadius = 10.0
        passwordConfirmTextField.layer.borderWidth = 1.0
        scrollView.addSubview(passwordConfirmTextField)
    }
    func setupCreateAccountButton(){
        createAccountButton = UIButton()
        createAccountButton.setTitle("Create Account", for: .normal)
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        createAccountButton.backgroundColor = UIColor.systemGreen
        createAccountButton.setTitleColor(UIColor.white, for: .normal)
        createAccountButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        createAccountButton.layer.cornerRadius = 10.0
        self.addSubview(createAccountButton)
    }
    
    func initConstrains(){
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            scrollView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            userNameTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            userNameTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 32),
            userNameTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            
            userEmailTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            userEmailTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 16),
            userEmailTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            userEmailTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            
            passwordTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: userEmailTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            passwordTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            
            passwordConfirmTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            passwordConfirmTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            passwordConfirmTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            passwordConfirmTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            
            createAccountButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            createAccountButton.topAnchor.constraint(equalTo: passwordConfirmTextField.bottomAnchor, constant: 16),
            createAccountButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            createAccountButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -50),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
