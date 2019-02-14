//
//  AlbumPickerViewModel.swift
//  iTunesAPI
//
//  Created by Yevhen Kharytonenko on 2/13/19.
//  Copyright © 2019 Yevhen Kharytonenko. All rights reserved.
//

import UIKit

public protocol AlbumPickerViewModelType {
  var albums: [Album] { get }
  func getAlbums(completion: @escaping () -> ())
}

class AlbumPickerViewModel: AlbumPickerViewModelType {

  var albums: [Album] = []

  private struct Constants {
    static let artistId = 1210395053
  }

  func getAlbums(completion: @escaping () -> ()) {
    downloadAlbums { [weak self] albums in
      var builder = [Album]()
      builder.append(contentsOf: albums)
      // I. First album is always empty so we can remove it
      builder.removeFirst()
      // II. Sort alphabetically
      builder.sort(by: { $0.collectionName ?? "" < $1.collectionName ?? "" })
      self?.albums = builder
      DispatchQueue.main.async() {
        completion()
      }
    }
  }

  private func downloadAlbums( completion: @escaping ([Album]) -> ()) {
    iTunesAPIRequest
      .lookupAlbum(artistId: Constants.artistId)
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
