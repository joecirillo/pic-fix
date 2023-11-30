//
//  CreateAccountViewController.swift
//  PicFix
//
//  Created by Joe Cirillo on 11/20/23.
//

import UIKit
import PhotosUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class CreateAccountViewController: UIViewController {
    let createAccountScreenView = CreateAccountScreenView()
    
    let storage = Storage.storage()
    
    let childProgressView = ProgressSpinnerViewController()
    
    var pickedPhoto:UIImage?
    
    override func loadView() {
        view = createAccountScreenView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        createAccountScreenView.profilePhotoButton.menu = getMenuImagePicker()
        
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
            showIncorrectErrorAlert()
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
    
    
    func getMenuImagePicker() -> UIMenu{
        let menuItems = [
            UIAction(title: "Camera",handler: {(_) in
                self.pickUsingCamera()
            }),
            UIAction(title: "Gallery",handler: {(_) in
                self.pickPhotoFromGallery()
            })
        ]
        
        return UIMenu(title: "Select source", children: menuItems)
    }
    
    func pickUsingCamera(){
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    func pickPhotoFromGallery(){
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }
    func showEmptyErrorAlert(){
        let alert = UIAlertController(title: "Error", message: "Please fill in empty inputs", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    func showIncorrectErrorAlert(){
        let alert = UIAlertController(title: "Error", message: "Passwords do not match", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}


extension CreateAccountViewController: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    DispatchQueue.main.async{
                        if let uwImage = image as? UIImage{
                            self.createAccountScreenView.profilePhotoButton.setImage(
                                uwImage.withRenderingMode(.alwaysOriginal),
                                for: .normal
                            )
                            self.pickedPhoto = uwImage
                        }
                    }
                })
            }
        }
    }
}

extension CreateAccountViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.createAccountScreenView.profilePhotoButton.setImage(
                image.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            self.pickedPhoto = image
        }else{
           // let controller = AddContactViewController()
            // controller.showErrorAlert("Could not load image.")
        }
    }
}
