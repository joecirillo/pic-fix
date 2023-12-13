//
//  EditProfileViewController.swift
//  PicFix
//
//  Created by Joe Cirillo on 11/28/23.
//

import UIKit
import PhotosUI
import FirebaseAuth

class EditProfileViewController: UIViewController {
    
    let editProfileScreen = EditProfileView()
    let notificationCenter = NotificationCenter.default
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?
    
    var pickedPhoto:UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = editProfileScreen
        
        editProfileScreen.profilePhotoButton.menu = getMenuImagePicker()
        
        let customBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .plain, // Adjust the style as needed (e.g., .plain, .done)
            target: self, // Set the target to the appropriate object
            action: #selector(onButtonSendBackTapped)
        )
        
        navigationItem.rightBarButtonItem = customBarButtonItem
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
               //codes omitted...
            }else{
                //codes omitted...
                self.currentUser = user

                //MARK: setting the profile photo...
                if let url = self.currentUser?.photoURL{
                    print("hi")
                    let profileScreen = ProfileView()

                    self.editProfileScreen.name.text = user?.displayName
                    self.editProfileScreen.email.text = user?.email
                }
                
                //codes omitted...
                
            }
        }
                
    }

        // Do any additional setup after loading the view.
    
    @objc func onButtonSendBackTapped(){
        if let text = editProfileScreen.profilePhotoButton.currentImage{
            //MARK: posting text to NotificationCenter...
            notificationCenter.post(
                name: Notification.Name("textFromSecondScreen"),
                object: text)
            showProfileChangeSavedAlert()
         //   navigationController?.popViewController(animated: true)
        }else{
            //Alert invalid input...
        }
        
    }
    
    func showProfileChangeSavedAlert(){
        let alert = UIAlertController(title: "Success", message: "The profile has been saved!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
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
}


extension EditProfileViewController: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    DispatchQueue.main.async{
                        if let uwImage = image as? UIImage{
                            self.editProfileScreen.profilePhotoButton.setImage(
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

extension EditProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.editProfileScreen.profilePhotoButton.setImage(
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

