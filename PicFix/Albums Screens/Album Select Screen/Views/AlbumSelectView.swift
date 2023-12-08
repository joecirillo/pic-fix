//
//  AlbumSelectView.swift
//  PicFix
//
//  Created by Christopher on 12/7/23.
//

import UIKit

class AlbumSelectView: UIView {
    var labelText: UILabel!
    var tableViewAlbumSelect: UITableView!
    var floatingButtonNewAlbum: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabelText()
        setupTableViewAlbumSelect()
        setupFloatingButtonNewAlbum()
        initConstraints()
    }
    
    func setupLabelText(){
        labelText = UILabel()
        labelText.font = .boldSystemFont(ofSize: 14)
        labelText.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelText)
    }
    
    func setupTableViewAlbumSelect(){
        tableViewAlbumSelect = UITableView()
        tableViewAlbumSelect.register(AlbumSelectTableViewCell.self, forCellReuseIdentifier: Configs.tableViewAlbumsID)
        tableViewAlbumSelect.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewAlbumSelect)
    }
    
    func setupFloatingButtonNewAlbum(){
        floatingButtonNewAlbum = UIButton(type: .system)
        floatingButtonNewAlbum.setTitle("", for: .normal)
        floatingButtonNewAlbum.setImage(UIImage(systemName: "rectangle.stack.fill.badge.plus")?.withRenderingMode(.alwaysOriginal), for: .normal)
        floatingButtonNewAlbum.contentHorizontalAlignment = .fill
        floatingButtonNewAlbum.contentVerticalAlignment = .fill
        floatingButtonNewAlbum.imageView?.contentMode = .scaleAspectFit
        floatingButtonNewAlbum.layer.cornerRadius = 16
        floatingButtonNewAlbum.imageView?.layer.shadowOffset = .zero
        floatingButtonNewAlbum.imageView?.layer.shadowRadius = 0.8
        floatingButtonNewAlbum.imageView?.layer.shadowOpacity = 0.7
        floatingButtonNewAlbum.imageView?.clipsToBounds = true
        floatingButtonNewAlbum.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(floatingButtonNewAlbum)
    }
    
    //MARK: setting up constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            labelText.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            labelText.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            tableViewAlbumSelect.topAnchor.constraint(equalTo: labelText.bottomAnchor, constant: 8),
            tableViewAlbumSelect.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewAlbumSelect.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewAlbumSelect.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            floatingButtonNewAlbum.widthAnchor.constraint(equalToConstant: 48),
            floatingButtonNewAlbum.heightAnchor.constraint(equalToConstant: 48),
            floatingButtonNewAlbum.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            floatingButtonNewAlbum.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
