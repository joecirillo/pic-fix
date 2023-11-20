//
//  CreateAccountFirebaseManager.swift
//  PicFix
//
//  Created by Joe Cirillo on 11/20/23.
//

import Foundation
import FirebaseAuth

extension CreateAccountViewController{
    
    func registerUser(){
        if let name = createAccountScreenView.userNameTextField.text,
           let email = createAccountScreenView.userEmailTextField.text,
           let password = createAccountScreenView.passwordTextField.text{
            Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                if error == nil{
                    self.setNameOfTheUserInFirebaseAuth(name: name, email: email)
                    print("no error")
                }
            })
        }
    }
    
    func setNameOfTheUserInFirebaseAuth(name: String, email: String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        
        changeRequest?.commitChanges(completion: {(error) in
            if error != nil{
                print("Error occured: \(String(describing: error))")
            }else{
                self.hideActivityIndicator()
                self.navigationController?.popViewController(animated: true)
            }
        })
    }

}
