//
//  EditProfileView.swift
//  PicFix
//
//  Created by Joe Cirillo on 11/28/23.
//

import UIKit

class EditProfileView: UIView {

    var contactPhoto: UIImageView!
    var name: UITextField!
    var email: UILabel!
    var photosDeletedLabel: UILabel!
    var megabytesSavedLabel: UILabel!


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupContactPhoto()
        setupName()
        setupEmail()
        setupPhotosDeletedLabel()
        setupMegabytesSavedLabel()
        
        initConstraints()
    }
    
    func setupContactPhoto(){
        contactPhoto = UIImageView()
        contactPhoto.image = UIImage(systemName: "person.crop.circle")
        contactPhoto.contentMode = .scaleToFill
        contactPhoto.clipsToBounds = true
        contactPhoto.layer.cornerRadius = 10
        contactPhoto.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contactPhoto)
    }
    
    func setupName(){
        name = UITextField()
        name.text = "Hi"
        name.font = UIFont.boldSystemFont(ofSize: 30)
        name.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(name)
    }
    
    func setupEmail(){
        email = UILabel()
        email.text = "Hi"
        email.font = email.font.withSize(20)
        email.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(email)
    }
    
    func setupPhotosDeletedLabel(){
        photosDeletedLabel = UILabel()
        photosDeletedLabel.text = "Hi"
        photosDeletedLabel.font = UIFont.boldSystemFont(ofSize: 20)
        photosDeletedLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(photosDeletedLabel)
    }
    
    func setupMegabytesSavedLabel(){
        megabytesSavedLabel = UILabel()
        megabytesSavedLabel.text = "Hi"
        megabytesSavedLabel.font = UIFont.boldSystemFont(ofSize: 20)
        megabytesSavedLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(megabytesSavedLabel)
    }
    

    
    func initConstraints(){
        NSLayoutConstraint.activate([
            contactPhoto.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            contactPhoto.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            contactPhoto.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -120),
            contactPhoto.heightAnchor.constraint(equalTo: contactPhoto.widthAnchor),
            
            name.topAnchor.constraint(equalTo: contactPhoto.bottomAnchor, constant: 32),
            name.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 24),
            email.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            photosDeletedLabel.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 24),
            photosDeletedLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            megabytesSavedLabel.topAnchor.constraint(equalTo: photosDeletedLabel.bottomAnchor, constant: 24),
            megabytesSavedLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
