//
//  AlbumPickerViewModel.swift
//  iTunesAPI
//
//  Created by Yevhen Kharytonenko on 2/13/19.
//  Copyright © 2019 Yevhen Kharytonenko. All rights reserved.
//

import UIKit

public protocol AlbumPickerViewModelType {
  var albumsCount: Int { get }

  func album(at index: Int) -> Album?
  func startDownloading(completion: @escaping () -> ())
}

class AlbumPickerViewModel: AlbumPickerViewModelType {

  private var albums: [Album] = []

  var albumsCount: Int { return albums.count }

  func album(at index: Int) -> Album? {
    return albums[index]
  }

  func startDownloading(completion: @escaping () -> ()) {
    downloadAlbums { [weak self] albums in
      self?.albums = albums
      DispatchQueue.main.async() {
        completion()
      }
    }
  }

  private func downloadAlbums( completion: @escaping ([Album]) -> ()) {
    iTunesAPIRequest
      .lookupAlbum(artistId: 909253)
      .perform { (result: iTunesAPIRequestResult<iTunesAlbumLookup>) in
        switch result {
        case .value(let lookup):
          completion(lookup.results)
        case .error(let description):
          print(description)
        }
    }
  }
}
