//
//  PhotoSwipeViewController.swift
//  PicFix
//
//  Created by Christopher on 11/27/23.
//
//  Swiping animation taken from
// https://exploringswift.com/blog/making-a-tinder-esque-card-swiping-interface-using-swift

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Photos

class PhotoSwipeViewController: UIViewController {
    let photoSwipeScreen = PhotoSwipeView()
    var currentUser:FirebaseAuth.User?
    let database = Firestore.firestore()
    var cardViewData = [Cards]()
    var cardImages = [String]()
    var stackContainer:StackContainerView!
    let notificationCenter = NotificationCenter.default
    let childProgressView = ProgressSpinnerViewController()


    override func loadView() {
        view = photoSwipeScreen
        stackContainer = StackContainerView()
        view.addSubview(stackContainer)
        setupStackContainer()
        stackContainer.translatesAutoresizingMaskIntoConstraints = false
        navigationItem.hidesBackButton = true
        
        if let originalImage = UIImage(systemName: "person.crop.circle") {
            // Resize the image to 50 by 50 pixels
            let coloredImage = originalImage.withTintColor(.black, renderingMode: .alwaysOriginal)
             
            // Create a UIBarButtonItem with the resized and colored image
            let customBarButtonItem = UIBarButtonItem(
                image: coloredImage,
                style: .plain,
                target: self,
                action: #selector(onButtonViewProfileTapped)
            )
            
            navigationItem.leftBarButtonItem = customBarButtonItem
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "PicFix"
        loadCardViewData()
        stackContainer.dataSource = self
        stackContainer.delegate = self
//        setupRightBarButton()
        
        // Do any additional setup after loading the view.
        notificationCenter.addObserver(
            self,
            selector: #selector(notificationReceivedForAlbumsSelected(notification:)),
            name: Notification.Name("albumsSelected"),
            object: nil)
        photoSwipeScreen.albumsButton.addTarget(self, action: #selector(onAlbumsButtonTapped), for: .touchUpInside)
        photoSwipeScreen.recentlyDeletedButton.addTarget(self, action: #selector(onRecentlyDeletedButtonTapped), for: .touchUpInside)

    }
    
//    func setupRightBarButton(){
//        //MARK: user is logged in...
//        let barIcon = UIBarButtonItem(
//            image: UIImage(systemName: "rectangle.portrait.and.arrow.forward"),
//            style: .plain,
//            target: self,
//            action: #selector(onLogOutBarButtonTapped)
//        )
//        
//        navigationItem.rightBarButtonItems = [barIcon]
//    }

    
    @objc func onAlbumsButtonTapped() {
        let albumsTableViewController = AlbumsTableViewController()
        albumsTableViewController.currentUser = self.currentUser
        navigationController?.pushViewController(albumsTableViewController, animated: true)
    }
    
    @objc func onRecentlyDeletedButtonTapped() {
        let photoGridViewController = PhotoGridViewController()
        let album = Album(albumName: "recentlyDeleted")
        photoGridViewController.album = album
        photoGridViewController.currentUser = currentUser
        
        navigationController?.pushViewController(photoGridViewController, animated: true)
    }
    
    func setupStackContainer() {
        stackContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60).isActive = true
        stackContainer.widthAnchor.constraint(equalToConstant: 300).isActive = true
        stackContainer.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
    
    func loadCardViewData() {
        loadImages(count: 6)
        self.stackContainer.remainingcards += 6
        
        for image in cardImages {
            getPHAsset(from: image) { asset in
                if let asset = asset {
                    // Use the PHAsset as needed
                    let path = self.getFilePath(for: asset)
                    let card = Cards(image: path)
                    self.cardViewData.append(card)
                } else {
                    print("PHAsset not found for file path: \(image)")
                }
            }
            
        }
    }
    
    func loadImages(count: Int) {
        for _ in 0...count {
            if let randomImage = getRandomImage() {
                cardImages.append(randomImage)
            } else {
                print("No image available or permission denied")
            }
        }
    }
    
    //MARK: upload a PHAsset reference to the image into Firebase.
    func getRandomImage() -> String? {
        var cardImage: String?
        //var imagePath: String?
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let result = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        if result.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(result.count)))
            let randomAsset = result[randomIndex]
            
            // get reference for selected photo
            if let filePath = getFilePath(for: randomAsset) {
                cardImage = filePath
            }
        }
        return cardImage
    }
    
    func getImageForFilePath(filePath: String) -> UIImage? {
        var cardImage: UIImage?
        getPHAsset(from: filePath) { asset in
            if let asset = asset {
                let requestOptions = PHImageRequestOptions()
                requestOptions.isSynchronous = true
                PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 300, height: 400),
                                                      contentMode: .aspectFill, options: requestOptions) { image, _ in
                    cardImage = image
                }
                
                if let pickedImage = cardImage {
                    // upload reference to firebase
                    if self.checkFilePathExists(filePath: filePath)! {
                        print("filepath not in firebase")
                        self.saveFilePath(filePath: filePath)
                        //imagePath = filePath
                        cardImage = pickedImage
                    } else { // unless it already exists
                        //imagePath = ""
                        cardImage = UIImage(named: "AppIcon")
                        print("Duplicate local identifier found")
                    }
                } else {
                    //imagePath = ""
                    print("did not get filepath")
                    cardImage = UIImage(named: "AppIcon")
                    print("error: file path not found")
                }
            } else {
                print("PHAsset not found for file path: \(filePath)")
            }
        }
        return cardImage
    }
    
    func getPHAsset(from filePath: String, completion: @escaping (PHAsset?) -> Void) {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]

        let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)

        let filename = (filePath as NSString).lastPathComponent

        for index in 0..<fetchResult.count {
            let asset = fetchResult.object(at: index)
            let assetResources = PHAssetResource.assetResources(for: asset)

            for resource in assetResources {
                if resource.originalFilename == filename {
                    completion(asset)
                    return
                }
            }
        }
        completion(nil)
    }
    
    func getFilePath(for asset: PHAsset) -> String? {
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        
        var filePath: String?
        
        let assetIdentifier = asset.localIdentifier
        
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                            in: .userDomainMask).first {
            let fileURL = documentDirectory.appendingPathComponent(assetIdentifier)
            filePath = fileURL.path()
            
            if !FileManager.default.fileExists(atPath: filePath!) {
                PHImageManager.default().requestImageDataAndOrientation(for: asset, options: options) { data, _, _, _ in
                    if let data = data {
                        try? data.write(to: fileURL, options: .atomic)
                    }
                }
            }
        }
        
        return filePath
    }
    
    func openAlbumSelector(image: String?) {
        let albumSelectViewController = AlbumSelectViewController()
        albumSelectViewController.addImage = image
        albumSelectViewController.currentUser = self.currentUser

        navigationController?.pushViewController(albumSelectViewController, animated: true)
        
    }
    
    @objc func onButtonViewProfileTapped(){
        let profileViewScreen = ProfileViewController()
        navigationController?.pushViewController(profileViewScreen, animated: true)
    }
    
    @objc func notificationReceivedForAlbumsSelected(notification: Notification){
        let db = Firestore.firestore()

        var albumImage = notification.userInfo!["image"]
        let albumNames = notification.userInfo!["name"]

        if let albums = albumNames as? [String], let filePath = albumImage as? String {
            for album in albums {
                let collectionFilePaths = db.collection("users").document((currentUser?.email)!).collection("albums").document(album).collection("filePaths")
                showActivityIndicator()
                do{
                    try collectionFilePaths.addDocument(from: filePath, completion: {(error) in
                        if error == nil{
                            self.navigationController?.popViewController(animated: true)
                            self.hideActivityIndicator()
                        }
                    })
                }catch{
                    print("Error adding document!")
                }
            }
        }
    }
    
//    @objc func onLogOutBarButtonTapped(){
//        let logoutAlert = UIAlertController(title: "Logging out!", message: "Are you sure want to log out?",
//            preferredStyle: .actionSheet)
//        logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .default, handler: {(_) in
//                do{
//                    try Auth.auth().signOut()
//                    if let navigationController = self.navigationController {
//                        navigationController.popToRootViewController(animated: true)
//                    }
//                }catch{
//                    print("Error occured!")
//                }
//            })
//        )
//        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//        
//        self.present(logoutAlert, animated: true)
//    }
}


extension PhotoSwipeViewController:ProgressSpinnerDelegate{
    func showActivityIndicator(){
        addChild(childProgressView)
        view.addSubview(childProgressView.view)
        childProgressView.didMove(toParent: self)
    }
    
    func hideActivityIndicator(){
        childProgressView.willMove(toParent: nil)
        childProgressView.view.removeFromSuperview()
        childProgressView.removeFromParent()
    }
}
