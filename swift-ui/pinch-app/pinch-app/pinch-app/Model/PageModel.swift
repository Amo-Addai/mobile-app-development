//
//  PageModel.swift
//  pinch-app
//
//  Created by Kwadwo Amo-Addai on 10/16/25.
//

import Foundation

struct Page: Identifiable {
    let id: Int
    let imageName: String
}

extension Page {
    var thumbnailName: String {
        return "thumb-" + imageName
    }
}
