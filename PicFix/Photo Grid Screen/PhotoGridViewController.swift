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
    var imageUrls: [URL]?
    var album: Album? // The album whose photos are to be displayed
    let database = Firestore.firestore()
    private let photoGridView = PhotoGridView()
    var currentUser:FirebaseAuth.User?

    override func loadView() {
        view = photoGridView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        photoGridView.collectionView.delegate = self
        photoGridView.collectionView.dataSource = self
    }

    // UICollectionViewDataSource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let documentRef = database.collection("users").document((currentUser?.email)!).collection("albums").document((album?.albumName)!).collection("imageUrls").addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
            if let documents = querySnapshot?.documents {
                for document in documents {
                    do{
                        let imageUrl = try document.data(as: URL.self)
                        self.imageUrls!.append(imageUrl)
                    }catch{
                        print(error)
                    }
                }
            }})
        
        return imageUrls?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell,
              let url = imageUrls?[indexPath.row] else {
            return UICollectionViewCell()
        }
        
        //var cellImage = UIImage(named: "AppIcon")
        getImageForUrl(imageUrl: url) { image in
            // Use the image here
            if let cellImage = image {
                cell.configure(with: cellImage)
                //once all images have been added

                // Do something with the randomImage
            } else {
                // Handle the case when an image couldn't be retrieved
            }
        }
        

        return cell
    }

    // UICollectionViewDelegate methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle photo selection, possibly show options to remove photo from album
    }
    
    func getImageForUrl(imageUrl: URL, completion: @escaping (UIImage?) -> Void) {
        var cardImage: UIImage?
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()

        DispatchQueue.global().async { [weak self] in
            defer {
                dispatchGroup.leave()
            }

            if let data = try? Data(contentsOf: imageUrl) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cardImage = image
                    }
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
                completion(cardImage)
        }
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
