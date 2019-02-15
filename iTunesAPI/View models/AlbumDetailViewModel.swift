//
//  AlbumDetailViewModel.swift
//  iTunesAPI
//
//  Created by Yevhen Kharytonenko on 2/15/19.
//  Copyright © 2019 Yevhen Kharytonenko. All rights reserved.
//

import UIKit

public protocol AlbumDetailViewModelType {
  var albumCoverImage: UIImage { get }
  var albumTitle: String { get }
  var albumDescription: String { get }
}

class AlbumDetailViewModel: AlbumDetailViewModelType {
  var albumCoverImage: UIImage
  var albumTitle: String
  var albumDescription: String

  init(album: Album,
       downloadedImage: UIImage) {
    self.albumCoverImage = downloadedImage
    self.albumTitle = album.collectionName ?? ""
    self.albumDescription = album.formattedLongDescription()
  }
}
