//
//  SwipeCardView.swift
//  PicFix
//
//  Created by Christopher on 11/29/23.
//
//  Swiping animation taken from
// https://exploringswift.com/blog/making-a-tinder-esque-card-swiping-interface-using-swift

import UIKit
import Photos
import FirebaseFirestore

class SwipeCardView: UIView {
    //MARK: - Properties
    var swipeView: UIView!
    var shadowView: UIView!
    var imageView: UIImageView!
    var filePath: String?
    var delegate: SwipeCardsDelegate?
    let database = Firestore.firestore()
    let notificationCenter = NotificationCenter.default

    let baseView = UIView()
    
    var dataSource: Cards? {
        didSet {
            guard let image = dataSource?.image else { return }
            imageView.image = image //getImageForFilePath(filePath: filePath)
        }
    }
    
//    func getImageForUrl(imageUrl: URL, completion: @escaping (UIImage?) -> Void) {
//        var cardImage: UIImage?
//        let dispatchGroup = DispatchGroup()
//        dispatchGroup.enter()
//
//        DispatchQueue.global().async { [weak self] in
//            defer {
//                dispatchGroup.leave()
//            }
//
//            if let data = try? Data(contentsOf: imageUrl) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        cardImage = image
//                    }
//                }
//            }
//        }
//        dispatchGroup.notify(queue: .main) {
//                completion(cardImage)
//        }
//    }
    
//    func getImageForFilePath(filePath: String) -> UIImage? {
//        var cardImage: UIImage?
//        getPHAsset(from: filePath) { asset in
//            if let asset = asset {
//                let requestOptions = PHImageRequestOptions()
//                requestOptions.isSynchronous = true
//                PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 300, height: 400),
//                                                      contentMode: .aspectFill, options: requestOptions) { image, _ in
//                    cardImage = image
//                }
//                
//                if let pickedImage = cardImage {
//                    // upload reference to firebase
//                    //imagePath = filePath
//                    cardImage = pickedImage
//                } else {
//                    //imagePath = ""
//                    print("did not get filepath")
//                    cardImage = UIImage(named: "AppIcon")
//                    print("error: file path not found")
//                }
//            } else {
//                print("PHAsset not found for file path: \(filePath)")
//                cardImage = UIImage(named: "AppIcon")
//
//            }
//        }
//        return cardImage
//    }
//    
//    func getPHAsset(from filePath: String, completion: @escaping (PHAsset?) -> Void) {
//        let fetchOptions = PHFetchOptions()
//        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
//
//        let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
//
//        let filename = (filePath as NSString).lastPathComponent
//
//        for index in 0..<fetchResult.count {
//            let asset = fetchResult.object(at: index)
//            let assetResources = PHAssetResource.assetResources(for: asset)
//
//            for resource in assetResources {
//                if resource.originalFilename == filename {
//                    completion(asset)
//                    return
//                }
//            }
//        }
//        completion(nil)
//    }
    
//    func getImageForPath(_ filePath: String) -> UIImage? {
//        if let image = UIImage(contentsOfFile: filePath) {
//            return image
//        } else {
//            print("Error loading image from file path: \(filePath)")
//            return UIImage(named: "AppIcon")
//        }
//    }
    
    //MARK: - Init
     override init(frame: CGRect) {
        super.init(frame: .zero)
        setupShadowView()
        setupSwipeView()
        setupImageView()
        addPanGestureOnCards()
        setupTapGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    
    func setupShadowView() {
        shadowView = UIView()
        shadowView.backgroundColor = .clear
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowOpacity = 0.8
        shadowView.layer.shadowRadius = 4.0
        addSubview(shadowView)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        shadowView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        shadowView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        shadowView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    func setupSwipeView() {
        swipeView = UIView()
        swipeView.layer.cornerRadius = 15
        swipeView.clipsToBounds = true
        shadowView.addSubview(swipeView)
        swipeView.translatesAutoresizingMaskIntoConstraints = false
        swipeView.leftAnchor.constraint(equalTo: shadowView.leftAnchor).isActive = true
        swipeView.rightAnchor.constraint(equalTo: shadowView.rightAnchor).isActive = true
        swipeView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor).isActive = true
        swipeView.topAnchor.constraint(equalTo: shadowView.topAnchor).isActive = true
    }
    
    func setupImageView() {
        imageView = UIImageView()
        swipeView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill//scaleToFill?
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "camera.fill")
        imageView.centerXAnchor.constraint(equalTo: swipeView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: swipeView.centerYAnchor, constant: -30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }

    func setupTapGesture() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
    }
    
    
    func addPanGestureOnCards() {
        self.isUserInteractionEnabled = true
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
    }
    
    //MARK: - Handlers
    @objc func handlePanGesture(sender: UIPanGestureRecognizer){
        let card = sender.view as! SwipeCardView
        let point = sender.translation(in: self)
        let centerOfParentContainer = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        card.center = CGPoint(x: centerOfParentContainer.x + point.x * 1.2, y: centerOfParentContainer.y + point.y)
        
        switch sender.state {
        case .ended:
            if (card.center.x) > 370 {
                delegate?.swipeDidEnd(on: card, imageUrl: nil)
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(x: centerOfParentContainer.x + point.x + 200, y: centerOfParentContainer.y + point.y + 75)
                    card.alpha = 0
                    self.layoutIfNeeded()
                }
                return
            }else if card.center.x < -40 {
                delegate?.swipeDidEnd(on: card, imageUrl: nil)
                notificationCenter.post(
                    name: .albumsSelected,
                    object: (dataSource?.image)!,
                            userInfo: ["imageUrl": (dataSource?.imageUrl)!, "albumNames": ["recentlyDeleted"]])
                //sendToRecentlyDeleted(image: (dataSource?.image)!)
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(x: centerOfParentContainer.x + point.x - 200, y: centerOfParentContainer.y + point.y + 75)
                    card.alpha = 0
                    self.layoutIfNeeded()
                }
                return
            } else if card.center.y < 50 {
                delegate?.swipeDidEnd(on: card, imageUrl: (dataSource?.imageUrl)!)
                //MARK: insert add to collection functionality
                //delegate.sendToAlbumSelect(
                
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(x: centerOfParentContainer.x + point.x, y: centerOfParentContainer.y + point.y + 200)
                    card.alpha = 0
                    self.layoutIfNeeded()
                }
                return
            }
            UIView.animate(withDuration: 0.2) {
                card.transform = .identity
                card.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
                self.layoutIfNeeded()
            }
        case .changed:
            let rotation = tan(point.x / (self.frame.width * 2.0))
            card.transform = CGAffineTransform(rotationAngle: rotation)
            
        default:
            break
        }
    }
    
//    //MARK: send photo to a collection of photos to be deleted
//    // implying that we save an extra collection of photos for recently deleted
//    func sendToRecentlyDeleted(image: UIImage) {
//        
//    }
    
    //MARK: used for actually deleting photos after user is done
    // change argument to images: [String]
    // for now, is only deleting randomly
    func deleteImages(filePaths: [String]) {
        PHPhotoLibrary.shared().performChanges({
            let assets = PHAsset.fetchAssets(with: .image, options: nil)
            if let assetToDelete = assets.firstObject {
                PHAssetChangeRequest.deleteAssets([assetToDelete] as NSArray)
            }
        }) { success, error in
            if success {
                print("Image deleted")
            } else {
                print("Error deleting image: \(String(describing: error))")
            }
        }
        for path in filePaths {
            do {
                try FileManager.default.removeItem(atPath: path)
                print("Local photo file deleted successfully at path: \(path)")
            } catch {
                print("Error deleting local photo file at path: \(path), error: \(error)")
            }
        }
        
        let collectionFilePaths = Firestore.firestore().collection("filePaths")
        
        collectionFilePaths.whereField("filePath", isEqualTo: filePaths).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching documents")
                return
            }
            
            guard let documents = snapshot?.documents, let document = documents.first else {
                print("No document found with file path")
                return
            }
            
            collectionFilePaths.document(document.documentID).delete { error in
                if let error = error {
                    print("error deleting document")
                } else {
                    print("photo deleted successfully")
                }
            }
        }
    }

    
    @objc func handleTapGesture(sender: UITapGestureRecognizer){
    }
    
  
}
