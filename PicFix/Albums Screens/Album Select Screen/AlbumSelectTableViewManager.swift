//
//  AlbumCheckBoxViewController.swift
//  PicFix
//
//  Created by Christopher on 12/7/23.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseFirestore

extension AlbumSelectViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let db = Firestore.firestore()

        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewAlbumsID, for: indexPath) as! AlbumSelectTableViewCell
        let checkBox = CheckBox()
        checkBox.albumName = albumsList[indexPath.row].albumName
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        cell.labelAlbumName.text = albumsList[indexPath.row].albumName
        self.albumSelectScreen.tableViewAlbumSelect.reloadData()
        //cell.wrapperCellView.addSubview(checkBox)
        return cell
    }
}
