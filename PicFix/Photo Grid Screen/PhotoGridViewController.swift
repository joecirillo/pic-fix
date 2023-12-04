//
//  PhotoGridViewController.swift
//  PicFix
//
//  Created by Yige Sun on 2023/12/3.
//

import UIKit

class PhotoGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var album: Album? // The album whose photos are to be displayed
    private let photoGridView = PhotoGridView()

    override func loadView() {
        view = photoGridView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = album?.name
        photoGridView.collectionView.delegate = self
        photoGridView.collectionView.dataSource = self
    }

    // UICollectionViewDataSource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return album?.images.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell,
              let image = album?.images[indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.configure(with: image)
        return cell
    }

    // UICollectionViewDelegate methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle photo selection, possibly show options to remove photo from album
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

