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
  var albumCoverViews: [AlbumCoverView] { get }
  var selectedAlbumIndex: Int { get set }
  var albumDetailViewModel: AlbumDetailViewModelType { get }

  func downloadAlbums(completion: @escaping () -> ())
}

class AlbumPickerViewModel: AlbumPickerViewModelType {

  private struct Constants {
    static let artistId = 358714030 // "Imagine Dragons"
    static let albumPlaceholderImageName = "album_placeholder"
  }

  var albums: [Album] = []

  var albumCoverViews: [AlbumCoverView] {
    var builder = [AlbumCoverView]()
    for album in albums {
      guard let coverView = Bundle.main.loadNibNamed(
        String(describing: AlbumCoverView.self),
        owner: nil
        )?.first as? AlbumCoverView,
        let link = album.artworkURLWithHigherResulution() else { continue }
      coverView.albumImage.setImageDownloaded(link)
      builder.append(coverView)
    }
    return builder
  }

  var selectedAlbumIndex: Int = -1

  var albumDetailViewModel: AlbumDetailViewModelType {
    return AlbumDetailViewModel(
      album: albums[selectedAlbumIndex],
      downloadedImage: albumCoverViews[selectedAlbumIndex].albumImage.image
        ?? UIImage(named: Constants.albumPlaceholderImageName)
        ?? UIImage()
    )
  }

  func downloadAlbums(completion: @escaping () -> ()) {
    getAlbumsUsingITunesAPI { [weak self] albums in
      var builder = [Album]()
      builder.append(contentsOf: albums)
      // I. First album is always empty so we can remove it
      builder.removeFirst()
      // II. Sort alphabetically
      builder.sort { $0.collectionName ?? "" < $1.collectionName ?? "" }
      self?.albums = builder
      DispatchQueue.main.async() {
        completion()
      }
    }
  }

  private func getAlbumsUsingITunesAPI( completion: @escaping ([Album]) -> ()) {
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
