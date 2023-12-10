//
//  ProfileScreenView.swift
//  PicFix
//
//  Created by Joe Cirillo on 11/27/23.
//

import UIKit

class ProfileView: UIView {


    var contactPhoto: UIImageView!
    var name: UILabel!
    var email: UILabel!
    var photosDeletedLabel: UILabel!
    var megabytesSavedLabel: UILabel!
    var logOutButton: UIButton!


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupContactPhoto()
        setupName()
        setupEmail()
        setupPhotosDeletedLabel()
        setupMegabytesSavedLabel()
        setupLogOutButton()
        
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
        name = UILabel()
        name.text = "AName"
        name.font = UIFont.boldSystemFont(ofSize: 30)
        name.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(name)
    }
    
    func setupEmail(){
        email = UILabel()
        email.text = "AEmail"
        email.font = email.font.withSize(20)
        email.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(email)
    }
    
    func updateEmailLabel(with email: String) {
        self.email.text = email
    }
    
    func setupPhotosDeletedLabel(){
        photosDeletedLabel = UILabel()
        photosDeletedLabel.text = "Photos deleted: "
        photosDeletedLabel.font = UIFont.boldSystemFont(ofSize: 20)
        photosDeletedLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(photosDeletedLabel)
    }
    
    func setupMegabytesSavedLabel(){
        megabytesSavedLabel = UILabel()
        megabytesSavedLabel.text = "Megabytes saved: "
        megabytesSavedLabel.font = UIFont.boldSystemFont(ofSize: 20)
        megabytesSavedLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(megabytesSavedLabel)
    }
    
    func setupLogOutButton(){
        logOutButton = UIButton(type: .system)
        logOutButton.setTitle("Log Out", for: .normal)
        logOutButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        logOutButton.backgroundColor = UIColor.systemRed
        logOutButton.setTitleColor(UIColor.white, for: .normal)
        logOutButton.layer.cornerRadius = 10
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logOutButton)
    }
    

    
    func initConstraints(){
        NSLayoutConstraint.activate([
            contactPhoto.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            contactPhoto.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            contactPhoto.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -320),
            contactPhoto.heightAnchor.constraint(equalTo: contactPhoto.widthAnchor),
            
            name.topAnchor.constraint(equalTo: contactPhoto.bottomAnchor, constant: 32),
            name.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 24),
            email.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            photosDeletedLabel.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 24),
            photosDeletedLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            megabytesSavedLabel.topAnchor.constraint(equalTo: photosDeletedLabel.bottomAnchor, constant: 24),
            megabytesSavedLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            
            // Constraints for Log Out Button
            logOutButton.topAnchor.constraint(equalTo: megabytesSavedLabel.bottomAnchor, constant: 32),
            logOutButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            logOutButton.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            logOutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
