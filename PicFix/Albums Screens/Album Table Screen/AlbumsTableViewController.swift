//
//  AlbumSelectViewController.swift
//  PicFix
//
//  Created by Christopher on 12/7/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Photos

class AlbumsTableViewController: UIViewController {
    let albumsScreen = AlbumsView()
    var currentUser:FirebaseAuth.User?
    let database = Firestore.firestore()
    var addImage: String?
    var addNames = [String]()
    var albumsList = [Album]()
    let notificationCenter = NotificationCenter.default
    //var filePaths = [FilePath]() //MARK: might not need this

    override func loadView() {
        view = albumsScreen
        //navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.database.collection("users")
            .document((self.currentUser?.email?.lowercased())!)
            .collection("albums")
        .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
            if let documents = querySnapshot?.documents{
                self.albumsList.removeAll()
                for document in documents{
                    do{
                        let album = try document.data(as: Album.self)
                        self.albumsList.append(album)
                    }catch{
                        print(error)
                    }
                }
                self.albumsList.sort(by: {$0.albumName! < $1.albumName!})
                self.albumsScreen.tableViewAlbums.reloadData()
            }
        })
        // Do any additional setup after loading the view.
    }
    
    @objc func newAlbumButtonTapped(){
        let createAlbumViewController = CreateAlbumViewController()
        createAlbumViewController.currentUser = self.currentUser
        navigationController?.pushViewController(createAlbumViewController, animated: true)
    }
    
    @objc func onBackBarButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    

    // something like: for tableviewcell, if button.isChecked,
    /*
     notificationCenter.post(
                 name: Notification.Name("albumSelected"),
                 object: "",
                 userInfo: ["image": (self.addImage)!, "name": "button.albumName"])
     */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = self.albumsList[indexPath.row]
        let photoGridViewController = PhotoGridViewController()
        photoGridViewController.album = details
        photoGridViewController.currentUser = currentUser
        
        navigationController?.pushViewController(photoGridViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumsScreen.labelText.text = "View albums"
        let barText = UIBarButtonItem(
            title: "Back",
            style: .plain,
            target: self,
            action: #selector(onBackBarButtonTapped)
        )
        self.albumsScreen.floatingButtonNewAlbum.isEnabled = true
        self.albumsScreen.floatingButtonNewAlbum.isHidden = false
        
        //MARK: patching table view delegate and data source...
        albumsScreen.tableViewAlbums.delegate = self
        albumsScreen.tableViewAlbums.dataSource = self
        albumsScreen.tableViewAlbums.separatorStyle = .none

        navigationItem.rightBarButtonItems = [barText]
        albumsScreen.floatingButtonNewAlbum.addTarget(self, action: #selector(newAlbumButtonTapped), for: .touchUpInside)
        view.bringSubviewToFront(albumsScreen.floatingButtonNewAlbum)
    }

}
