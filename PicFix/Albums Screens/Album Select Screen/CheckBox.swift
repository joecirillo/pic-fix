//
//  CheckBox.swift
//  PicFix
//
//  Created by Christopher on 12/7/23.
//

import Foundation
import UIKit

class CheckBox: UIButton {
    
    //images
    let checkedImage = UIImage(named: "checkmark.square.fill")
    let unCheckedImage = UIImage(named: "checkmark.square")
    
    //bool propety
    var isChecked:Bool = false{
        didSet{
            self.updateImage()
        }
    }
    var albumName: String?
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(CheckBox.buttonClicked), for: UIControl.Event.touchUpInside)
        self.imageView?.contentMode = .scaleAspectFit
        self.updateImage()
    }
    
    func updateImage() {
        setImage(isChecked ? checkedImage : unCheckedImage, for: [])
    }

    @objc func buttonClicked(sender:UIButton) {
        if(sender == self){
            isChecked.toggle()
        }
    }

}
