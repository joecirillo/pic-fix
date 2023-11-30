//
//  MainScreenView.swift
//  PicFix
//
//  Created by Joe Cirillo on 11/16/23.
//

import UIKit

class MainScreenView: UIView {
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var logInButton = UIButton()
    var signUpButton = UIButton()
    var logoImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupEmail()
        setupPassword()
        setupLogInButton()
        setupSignUpButton()
        setupLogoImage()
        togglePasswordVisibility()
        
        initConstraints()
    }
    
    
    func setupEmail(){
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.borderStyle = .roundedRect
        emailTextField.layer.borderColor = UIColor.gray.cgColor
        emailTextField.layer.cornerRadius = 10.0
        emailTextField.layer.borderWidth = 1.0
        self.addSubview(emailTextField)
    }
    func setupPassword(){
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.textContentType = .password
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.layer.borderColor = UIColor.gray.cgColor
        passwordTextField.layer.cornerRadius = 10.0
        passwordTextField.layer.borderWidth = 1.0
        self.addSubview(passwordTextField)
        
        // Add an eye button next to the passwordTextField
        let eyeButton = UIButton(type: .custom)
        eyeButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        eyeButton.frame = CGRect(x: -10, y: 0, width: 30, height: 30)
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        // Set the eye button as the rightView of passwordTextField
        passwordTextField.rightView = eyeButton
        passwordTextField.rightViewMode = .always
    }
    
    @objc func togglePasswordVisibility() {
        // Toggle the isSecureTextEntry property
        passwordTextField.isSecureTextEntry.toggle()
        // Update the eye button image based on the current state
        if passwordTextField.isSecureTextEntry {
            (passwordTextField.rightView as? UIButton)?.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        } else {
            (passwordTextField.rightView as? UIButton)?.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
    }
     
    func setupLogInButton(){
        logInButton = UIButton()
        logInButton.setTitle("Log In", for: .normal)
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.backgroundColor = UIColor.systemGreen
        logInButton.setTitleColor(UIColor.white, for: .normal)
        logInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        logInButton.layer.cornerRadius = 10.0
        self.addSubview(logInButton)
    }
    
    func setupSignUpButton(){
        signUpButton = UIButton()
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.backgroundColor = UIColor.systemGreen
        signUpButton.setTitleColor(UIColor.white, for: .normal)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        signUpButton.layer.cornerRadius = 10.0
        self.addSubview(signUpButton)
    }
    
    func setupLogoImage(){
        logoImage = UIImageView()
        logoImage.image = UIImage(named: "AppIcon")
        logoImage.contentMode = .scaleAspectFill
        logoImage.clipsToBounds = true
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logoImage)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            
            logoImage.heightAnchor.constraint(equalToConstant: 250),
            logoImage.widthAnchor.constraint(equalToConstant: 250),
            logoImage.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -64),
            logoImage.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            
            emailTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -16),
            emailTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            emailTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            
            passwordTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            passwordTextField.bottomAnchor.constraint(equalTo: logInButton.topAnchor, constant: -16),
            passwordTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            
            logInButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            logInButton.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -16),
            logInButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            logInButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            
            signUpButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            signUpButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            signUpButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -50)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
