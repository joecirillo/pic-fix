//
//  PhotoSwipeViewController.swift
//  PicFix
//
//  Created by Christopher on 11/27/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class PhotoSwipeViewController: UIViewController {
    let photoSwipeScreen = PhotoSwipeView()
    var currentUser:FirebaseAuth.User?
    let database = Firestore.firestore()
    var cardViewData = [Cards(bgColor: UIColor(red:0.96, green:0.81, blue:0.46, alpha:1.0), image: "hamburger"),
                        Cards(bgColor: UIColor(red:0.29, green:0.64, blue:0.96, alpha:1.0), image: "puppy"),
                        Cards(bgColor: UIColor(red:0.29, green:0.63, blue:0.49, alpha:1.0), image: "poop"),
                        Cards(bgColor: UIColor(red:0.69, green:0.52, blue:0.38, alpha:1.0), image: "panda"),
                        Cards(bgColor: UIColor(red:0.90, green:0.99, blue:0.97, alpha:1.0), image: "subway"),
                        Cards(bgColor: UIColor(red:0.83, green:0.82, blue:0.69, alpha:1.0), image: "robot")]
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
        stackContainer.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func setupStackContainer() {
        stackContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60).isActive = true
        stackContainer.widthAnchor.constraint(equalToConstant: 300).isActive = true
        stackContainer.heightAnchor.constraint(equalToConstant: 400).isActive = true
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
