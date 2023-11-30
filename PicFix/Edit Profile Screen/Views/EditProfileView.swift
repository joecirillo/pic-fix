//
//  EditProfileView.swift
//  PicFix
//
//  Created by Joe Cirillo on 11/28/23.
//

import UIKit

class EditProfileView: UIView {

    var profilePhotoButton: UIButton!
    var name: UITextField!
    var email: UILabel!
    var photosDeletedLabel: UILabel!
    var megabytesSavedLabel: UILabel!


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        editName()
        editProfilePhotoButton()
        editEmail()
        
        initConstraints()
    }
    
    func editProfilePhotoButton() {
        profilePhotoButton = UIButton(type: .system)
        profilePhotoButton.setTitle("", for: .normal)
        profilePhotoButton.setImage(UIImage(systemName: "person.crop.circle"), for: .normal)
        profilePhotoButton.contentHorizontalAlignment = .fill
        profilePhotoButton.contentVerticalAlignment = .fill
        profilePhotoButton.imageView?.contentMode = .scaleAspectFit
        profilePhotoButton.showsMenuAsPrimaryAction = true
        profilePhotoButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profilePhotoButton)
    }
    
    func editName(){
        name = UITextField()
        name.text = "Hi"
        name.font = UIFont.boldSystemFont(ofSize: 30)
        name.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(name)
    }
    
    func editEmail(){
        email = UILabel()
        email.text = "Hi"
        email.font = email.font.withSize(20)
        email.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(email)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            profilePhotoButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            profilePhotoButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            profilePhotoButton.widthAnchor.constraint(equalToConstant: 100),
            profilePhotoButton.heightAnchor.constraint(equalToConstant: 100),
            
            name.topAnchor.constraint(equalTo: profilePhotoButton.bottomAnchor, constant: 32),
            name.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 24),
            email.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
