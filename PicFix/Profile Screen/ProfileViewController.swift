//
//  ProfileScreenViewController.swift
//  PicFix
//
//  Created by Joe Cirillo on 11/27/23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profileScreen = ProfileView()
    
    let notificationCenter = NotificationCenter.default

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = profileScreen

        let customBarButtonItem = UIBarButtonItem(
            title: "Edit",
            style: .plain, // Adjust the style as needed (e.g., .plain, .done)
            target: self, // Set the target to the appropriate object
            action: #selector(onEditButtonTapped)
        )
        
        navigationItem.rightBarButtonItem = customBarButtonItem
        
        notificationCenter.addObserver(
            self,
            selector: #selector(notificationReceivedForTextChanged(notification:)),
            name: Notification.Name("textFromSecondScreen"),
            object: nil)
    }
    
    @objc func onEditButtonTapped() {
        let editProfileScreen = EditProfileViewController()
        navigationController?.pushViewController(editProfileScreen, animated: true)
    }
    
    @objc func notificationReceivedForTextChanged(notification: Notification){
        profileScreen.contactPhoto.image = (notification.object as! UIImage)
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
