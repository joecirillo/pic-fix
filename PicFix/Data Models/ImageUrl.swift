//
//  Photo.swift
//  PicFix
//
//  Created by Christopher on 11/30/23.
//

import Foundation
import FirebaseFirestoreSwift
import UIKit

struct ImageUrl: Codable {
    @DocumentID var id: String?
    var imageUrl: URL?
    
    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
    }
}
