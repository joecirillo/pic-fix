//
//  Cards.swift
//  PicFix
//
//  Created by Christopher on 11/29/23.
//
import Foundation
import UIKit

struct Cards {
    var image: UIImage?
    var imageUrl: URL?
    init(image: UIImage?, imageUrl: URL?) {
        self.image = image
        self.imageUrl = imageUrl
    }
}
