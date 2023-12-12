//
//  Photo.swift
//  PicFix
//
//  Created by Christopher on 11/30/23.
//

import Foundation
import FirebaseFirestoreSwift
import UIKit

struct ImageRef: Codable {
    @DocumentID var id: String?
    var imageRef: String?
      
    init(imageRef: String?) {
        self.imageRef = imageRef
    }
}
