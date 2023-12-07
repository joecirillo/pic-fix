//
//  Photo.swift
//  PicFix
//
//  Created by Christopher on 11/30/23.
//

import Foundation
import FirebaseFirestoreSwift

struct PhotoUrl: Codable {
    @DocumentID var id: String?
    var photoUrl: String?
      
    init(photoUrl: String?) {
        self.photoUrl = photoUrl
    }
}
