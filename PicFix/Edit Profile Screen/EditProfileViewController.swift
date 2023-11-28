//
//  EditProfileViewController.swift
//  PicFix
//
//  Created by Joe Cirillo on 11/28/23.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    let editProfileScreen = EditProfileView()
    
    let notificationCenter = NotificationCenter.default

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = editProfileScreen
        
        let customBarButtonItem = UIBarButtonItem(
            title: "Edit",
            style: .plain, // Adjust the style as needed (e.g., .plain, .done)
            target: self, // Set the target to the appropriate object
            action: #selector(onButtonSendBackTapped)
        )
        
        navigationItem.rightBarButtonItem = customBarButtonItem
                
    }

        // Do any additional setup after loading the view.
    
    @objc func onButtonSendBackTapped(){
        if let image = editProfileScreen.contactPhoto.image{
            //MARK: posting text to NotificationCenter...
            notificationCenter.post(
                name: Notification.Name("textFromSecondScreen"),
                object: image)
            navigationController?.popViewController(animated: true)
        }else{
            //Alert invalid input...
        }
        
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
