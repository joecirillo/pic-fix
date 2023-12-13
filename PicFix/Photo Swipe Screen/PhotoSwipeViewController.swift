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
import FirebaseStorage
import Photos
import PhotosUI

class PhotoSwipeViewController: UIViewController {
    let photoSwipeScreen = PhotoSwipeView()
    var currentUser:FirebaseAuth.User?
    let database = Firestore.firestore()
    let storage = Storage.storage()
    var cardViewData = [Cards]()
    var cardImages = [UIImage]()
    var stackContainer:StackContainerView!
    let notificationCenter = NotificationCenter.default
    let childProgressView = ProgressSpinnerViewController()
    var pickedImages = [UIImage]()
    var albumsList = [Album]()
    var recentlyDeleted = Album(albumName: "recentlyDeleted")
    var urls = [URL]()


    override func loadView() {
        view = photoSwipeScreen
        stackContainer = StackContainerView()
        view.addSubview(stackContainer)
        setupStackContainer()
        self.uploadLocalPhotos()
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
        //loadCardViewData()
        stackContainer.dataSource = self
        stackContainer.delegate = self
        setupRightBarButton()
        
        // Do any additional setup after loading the view.
        notificationCenter.addObserver(
            self,
            selector: #selector(notificationReceivedForUploadImages(notification:)),
            name: .uploadImages,
            object: nil)
        notificationCenter.addObserver(
            self,
            selector: #selector(notificationReceivedForImagesUploaded(notification:)),
            name: .imagesUploaded,
            object: nil)
        notificationCenter.addObserver(
            self,
            selector: #selector(notificationReceivedForAlbumsSelected(notification:)),
            name: .albumsSelected,
            object: nil)
        photoSwipeScreen.albumsButton.addTarget(self, action: #selector(onAlbumsButtonTapped), for: .touchUpInside)
        photoSwipeScreen.recentlyDeletedButton.addTarget(self, action: #selector(onRecentlyDeletedButtonTapped), for: .touchUpInside)

    }
    
    func setupRightBarButton(){
        //MARK: user is logged in...
        let barIcon = UIBarButtonItem(
            image: UIImage(systemName: "rectangle.portrait.and.arrow.forward"),
            style: .plain,
            target: self,
            action: #selector(onLogOutBarButtonTapped)
        )
        
        navigationItem.rightBarButtonItems = [barIcon]
    }

    
    @objc func onAlbumsButtonTapped() {
        let albumsTableViewController = AlbumsTableViewController()
        albumsTableViewController.currentUser = self.currentUser
        navigationController?.pushViewController(albumsTableViewController, animated: true)
    }
    
    @objc func onRecentlyDeletedButtonTapped() {
        let photoGridViewController = PhotoGridViewController()
        photoGridViewController.album = self.recentlyDeleted
        photoGridViewController.title = "Recently Deleted"
        photoGridViewController.currentUser = currentUser
        
        navigationController?.pushViewController(photoGridViewController, animated: true)
    }
    
    func setupStackContainer() {
        stackContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60).isActive = true
        stackContainer.widthAnchor.constraint(equalToConstant: 300).isActive = true
        stackContainer.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }

    @objc func notificationReceivedForUploadImages(notification: Notification) {
        self.uploadImageToFirebaseStorage(images: self.pickedImages)
    }
    
    @objc func notificationReceivedForImagesUploaded(notification: Notification) {
        self.loadCardViewData()
    }

    func loadCardViewData() {
        loadImages(count: 6)
    }
    
    func loadImages(count: Int) {
        for i in 0...count {
            getRandomImage { image, url in
                // Use the image here
                if let randomImage = image {
                    self.cardImages.append(randomImage)
                    //once all images have been added
                    if i == count - 1 {
                        self.stackContainer.remainingcards += 6
                        
                        for image in self.cardImages {
                            let card = Cards(image: image, imageUrl: url)
                            self.cardViewData.append(card)
                            if self.cardViewData.count == self.cardImages.count - 1 {
                                self.stackContainer.reloadData()
                            }
                        }
                    }
                    // Do something with the randomImage
                } else {
                    // Handle the case when an image couldn't be retrieved
                }
            }
//            if let image = self.getRandomImage() {
//                self.cardImages.append(image)
//            }

        }
        // This code will be executed once loadImages() is complete


        // You can perform additional actions here, as needed
        print("Card view data loaded successfully!")
    }
    
    func getRandomImage(completion: @escaping (UIImage?, URL?) -> Void) {
        var randomImage = UIImage(named: "AppIcon")//self.pickedImages[randomIndex]
        
        let randomIndex = Int.random(in: 0..<self.urls.count)
        let imageRef = self.urls[randomIndex]
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()

        DispatchQueue.global().async { [weak self] in
            defer {
                dispatchGroup.leave()
            }

            if let data = try? Data(contentsOf: imageRef) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        randomImage = image
                    }
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
                completion(randomImage, imageRef)
            }
    }
    
    func openAlbumSelector(imageUrl: URL) {
        let albumSelectViewController = AlbumSelectViewController()
        albumSelectViewController.imageUrl = imageUrl
        albumSelectViewController.currentUser = self.currentUser

        navigationController?.pushViewController(albumSelectViewController, animated: true)
        
    }
    
    @objc func onButtonViewProfileTapped(){
        let profileViewScreen = ProfileViewController()
        navigationController?.pushViewController(profileViewScreen, animated: true)
    }
    
    @objc func notificationReceivedForAlbumsSelected(notification: Notification){
        let db = Firestore.firestore()

        let imageUrl = notification.userInfo!["imageUrl"]
        let albumNames = notification.userInfo!["albumNames"]

        if let albums = albumNames as? [String], let url = imageUrl as? URL {
            for album in albums {
                let collectionCardImages = db.collection("users").document((currentUser?.email)!).collection("albums").document(album).collection("imageUrls")
                showActivityIndicator()
                let imageUrl = ImageUrl(imageUrl: url)
                do{
                    try collectionCardImages.addDocument(from: imageUrl, completion: {(error) in
                        if error == nil {
                            if album != "recentlyDeleted" {
                                self.navigationController?.popViewController(animated: true)

                            }
                            self.hideActivityIndicator()
                        }
                    })
                }catch{
                    print("Error adding document!")
                }
            }
        }
    }
    
    @objc func onLogOutBarButtonTapped(){
        let logoutAlert = UIAlertController(title: "Logging out!", message: "Are you sure want to log out?",
            preferredStyle: .actionSheet)
        logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .default, handler: {(_) in
                do{
                    try Auth.auth().signOut()
                }catch{
                    print("Error occured!")
                }
            })
        )
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(logoutAlert, animated: true)
    }
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

extension PhotoSwipeViewController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    DispatchQueue.main.async{
                        if let uwImage = image as? UIImage{
//                            self.photoSwipeScreen.buttonTakePhoto.setImage(
//                                uwImage.withRenderingMode(.alwaysOriginal),
//                                for: .normal
//                            )
                            print("picked images")
                            self.pickedImages.append(uwImage)

                            if self.pickedImages.count >= 6 {
                                self.notificationCenter.post(
                                    name: Notification.Name("uploadImages"),
                                    object: nil)
                            }
                        }
                    }
                })
            }
        }
    }
}
