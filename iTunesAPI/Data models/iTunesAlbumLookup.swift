//
//  iTunesAlbumLookup.swift
//  iTunesAPI
//
//  Created by Yevhen Kharytonenko on 2/13/19.
//  Copyright © 2019 Yevhen Kharytonenko. All rights reserved.
//

import Foundation

public struct iTunesAlbumLookup: Codable {
  let resultCount: Int
  let results: [Album]
}
