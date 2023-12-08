//
//  CheckboxTableViewCell.swift
//  PicFix
//
//  Created by Christopher on 12/7/23.
//

import UIKit

class AlbumSelectTableViewCell: UITableViewCell {
    var checkBox: CheckBox!
    var labelAlbumName: UILabel!
    var wrapperCellView: UIView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelAlbumName()
        //setupCheckBox()
        
        initConstraints()
    }
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        
        //working with the shadows and colors...
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 6.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupLabelAlbumName(){
        labelAlbumName = UILabel()
        labelAlbumName.font = UIFont.boldSystemFont(ofSize: 20)
        labelAlbumName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelAlbumName)
    }
    
//    func setupCheckBox() {
//        checkBox = CheckBox()
//        checkBox.albumName = labelAlbumName.text
//        checkBox.translatesAutoresizingMaskIntoConstraints = false
//
//        wrapperCellView.addSubview(checkBox)
//    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            labelAlbumName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelAlbumName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelAlbumName.heightAnchor.constraint(equalToConstant: 20),
            labelAlbumName.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor),
            
            checkBox.topAnchor.constraint(equalTo: labelAlbumName.topAnchor),
            checkBox.leadingAnchor.constraint(equalTo: labelAlbumName.trailingAnchor),
            checkBox.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: 8),

            wrapperCellView.heightAnchor.constraint(equalToConstant: 72)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
