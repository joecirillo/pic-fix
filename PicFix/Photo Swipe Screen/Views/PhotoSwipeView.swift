//
//  PhotoSwipeView.swift
//  PicFix
//
//  Created by Christopher on 11/27/23.
//

import UIKit

class PhotoSwipeView: UIView {
    var albumsButton:UIButton!
    var recentlyDeletedButton:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
                
        setupAlbumsButton()
        setupRecentlyDeletedButton()

        initConstraints()
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
            albumsButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            albumsButton.bottomAnchor.constraint(equalTo: recentlyDeletedButton.topAnchor, constant: -16),
            albumsButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            albumsButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            
            recentlyDeletedButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            recentlyDeletedButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            recentlyDeletedButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            recentlyDeletedButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -50)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
