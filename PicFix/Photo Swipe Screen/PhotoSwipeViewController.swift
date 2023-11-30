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
    var cardImages = [UIImage]()
    var stackContainer:StackContainerView!

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
        // Do any additional setup after loading the view.
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
            let card = Cards(image: image)
            cardViewData.append(card)
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
    func getRandomImage() -> UIImage? {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let result = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        if result.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(result.count)))
            let randomAsset = result[randomIndex]
            
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = true
            
            var randomImage: UIImage?
            
            PHImageManager.default().requestImage(for: randomAsset, targetSize: CGSize(width: 300, height: 400),
                                                  contentMode: .aspectFill, options: requestOptions) { image, _ in
                randomImage = image
            }
            return randomImage
        }
        return UIImage(named: "AppIcon")
        
    }
    
    @objc func onButtonViewProfileTapped(){
        let profileViewScreen = ProfileViewController()
        navigationController?.pushViewController(profileViewScreen, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
