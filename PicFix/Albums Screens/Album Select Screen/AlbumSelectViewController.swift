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

class AlbumSelectViewController: UIViewController {
    let albumSelectScreen = AlbumSelectView()
    var currentUser:FirebaseAuth.User?
    let database = Firestore.firestore()
    var addImage: String?
    var addNames = [String]()
    var albumsList = [Album]()
    let notificationCenter = NotificationCenter.default
    //var filePaths = [FilePath]() //MARK: might not need this

    override func loadView() {
        view = albumSelectScreen
        //navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumSelectScreen.labelText.text = "Select albums to add:"
        let barText = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(onDoneBarButtonTapped)
        )
        self.albumSelectScreen.floatingButtonNewAlbum.isEnabled = true
        self.albumSelectScreen.floatingButtonNewAlbum.isHidden = false

        
        navigationItem.rightBarButtonItems = [barText]
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
                self.albumSelectScreen.tableViewAlbumSelect.reloadData()
            }
        })
        albumSelectScreen.floatingButtonNewAlbum.addTarget(self, action: #selector(newAlbumButtonTapped), for: .touchUpInside)
        view.bringSubviewToFront(albumSelectScreen.floatingButtonNewAlbum)
        // Do any additional setup after loading the view.
    }
    
    @objc func newAlbumButtonTapped(){
        let createAlbumViewController = CreateAlbumViewController()
        createAlbumViewController.currentUser = self.currentUser
        navigationController?.pushViewController(createAlbumViewController, animated: true)
    }
    
    @objc func onDoneBarButtonTapped() {
        for cell in albumSelectScreen.tableViewAlbumSelect.visibleCells {
            if let albumCell = cell as? AlbumSelectTableViewCell {
                let checkBox = albumCell.checkBox
                
                if let checked = checkBox?.isChecked {
                    if checked {
                        if let user = currentUser {
                            notificationCenter.post(
                                        name: Notification.Name("albumsSelected"),
                                        object: "",
                                        userInfo: ["image": addImage!, "albumNames": addNames])
                        }
                    }
                }
            }
        }
    }
    

    // something like: for tableviewcell, if button.isChecked,
    /*
     notificationCenter.post(
                 name: Notification.Name("albumSelected"),
                 object: "",
                 userInfo: ["image": (self.addImage)!, "name": "button.albumName"])
     */
    
   
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
