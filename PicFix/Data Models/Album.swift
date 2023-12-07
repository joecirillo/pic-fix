//
//  Album.swift
//  PicFix
//
//  Created by Christopher on 12/7/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Album: Codable {
    @DocumentID var id: String?
    var albumName: String?
    var images: [String]?
    
    init(albumName: String?, images: [String]?) {
        self.albumName = albumName
        self.images = images
    }
}
