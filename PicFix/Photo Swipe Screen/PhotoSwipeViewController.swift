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
    
    override func loadView() {
        view = photoSwipeScreen
        
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

        // Do any additional setup after loading the view.
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
