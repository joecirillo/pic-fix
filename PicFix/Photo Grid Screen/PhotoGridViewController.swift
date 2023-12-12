//
//  PhotoGridViewController.swift
//  PicFix
//
//  Created by Yige Sun on 2023/12/3.
//
import UIKit
import Photos
import FirebaseFirestore
import FirebaseAuth

class PhotoGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var filePaths: [String]?
    var album: Album? // The album whose photos are to be displayed
    let database = Firestore.firestore()
    private let photoGridView = PhotoGridView()
    var currentUser:FirebaseAuth.User?

    override func loadView() {
        view = photoGridView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = album?.albumName
        photoGridView.collectionView.delegate = self
        photoGridView.collectionView.dataSource = self
    }

    // UICollectionViewDataSource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let documentRef = database.collection("users").document((currentUser?.email)!).collection("albums").document((album?.albumName)!).collection("filePaths").addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
            if let documents = querySnapshot?.documents {
                for document in documents {
                    do{
                        let filePath = try document.data(as: String.self)
                        self.filePaths!.append(filePath)
                    }catch{
                        print(error)
                    }
                }
            }})
        
        return filePaths?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell,
              let image = filePaths?[indexPath.row] else {
            return UICollectionViewCell()
        }
        let cellImage = getImageForFilePath(filePath: image)
        cell.configure(with: cellImage!)
        return cell
    }

    // UICollectionViewDelegate methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle photo selection, possibly show options to remove photo from album
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
                    //imagePath = filePath
                    cardImage = pickedImage
                } else {
                    //imagePath = ""
                    print("did not get filepath")
                    cardImage = UIImage(named: "AppIcon")
                    print("error: file path not found")
                }
            } else {
                cardImage = UIImage(named: "AppIcon")
                print("actually here")
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
}

// Custom UICollectionViewCell
class PhotoCell: UICollectionViewCell {
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with image: UIImage) {
        imageView.image = image
    }
}
