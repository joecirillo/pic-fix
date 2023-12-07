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

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabelText()
        setupTableViewAlbumSelect()
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
    
    //MARK: setting up constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            labelText.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            labelText.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            tableViewAlbumSelect.topAnchor.constraint(equalTo: labelText.bottomAnchor, constant: 8),
            tableViewAlbumSelect.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewAlbumSelect.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewAlbumSelect.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
