//
//  PhotoSwipeView.swift
//  PicFix
//
//  Created by Christopher on 11/27/23.
//

import UIKit

class PhotoSwipeView: UIView {
    var photoImage = UIImageView()
    var albumsButton = UIButton()
    var recentlyDeletedButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupPhotoImage()
        setupAlbumsButton()
        setupRecentlyDeletedButton()
        
        initConstraints()
    }
    
    func setupPhotoImage(){
        photoImage = UIImageView()
        photoImage.image = UIImage(named: "AppIcon")
        photoImage.contentMode = .scaleAspectFill
        photoImage.clipsToBounds = true
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(photoImage)
    }
     
    func setupAlbumsButton(){
        albumsButton = UIButton()
        albumsButton.setTitle("Albums", for: .normal)
        albumsButton.translatesAutoresizingMaskIntoConstraints = false
        albumsButton.backgroundColor = UIColor.systemGreen
        albumsButton.setTitleColor(UIColor.white, for: .normal)
        albumsButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        albumsButton.layer.cornerRadius = 10.0
        self.addSubview(albumsButton)
    }
    
    func setupRecentlyDeletedButton(){
        recentlyDeletedButton = UIButton()
        recentlyDeletedButton.setTitle("Recently Deleted", for: .normal)
        recentlyDeletedButton.translatesAutoresizingMaskIntoConstraints = false
        recentlyDeletedButton.backgroundColor = UIColor.systemGreen
        recentlyDeletedButton.setTitleColor(UIColor.white, for: .normal)
        recentlyDeletedButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        recentlyDeletedButton.layer.cornerRadius = 10.0
        self.addSubview(recentlyDeletedButton)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            
            photoImage.heightAnchor.constraint(equalToConstant: 250),
            photoImage.widthAnchor.constraint(equalToConstant: 250),
            photoImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            photoImage.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            albumsButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            albumsButton.topAnchor.constraint(equalTo: photoImage.bottomAnchor, constant: -16),
            albumsButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            albumsButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            
            recentlyDeletedButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            recentlyDeletedButton.topAnchor.constraint(equalTo: albumsButton.bottomAnchor, constant: -32),
            recentlyDeletedButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            recentlyDeletedButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -50)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
