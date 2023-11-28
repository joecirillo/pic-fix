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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
