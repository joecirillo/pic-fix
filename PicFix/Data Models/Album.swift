//
//  Album.swift
//  PicFix
//
//  Created by Yige Sun on 2023/12/3.
//

import Foundation
import UIKit

class Album {
    var name: String
    var images: [UIImage]

    init(name: String, images: [UIImage] = []) {
        self.name = name
        self.images = images
    }
}
