//
//  CreateAlbumAlerts.swift
//  PicFix
//
//  Created by Christopher on 12/7/23.
//

import Foundation
import UIKit

extension CreateAlbumViewController{
    
    func showNameNotEnteredAlert(){
        let alert = UIAlertController(title: "Error!", message: "Album name not entered. Please enter a valid name.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
    }
    
    func showNameAlreadyExistsAlert(){
        let alert = UIAlertController(title: "Error!", message: "Album exists. Please enter a different name.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
    }
}
