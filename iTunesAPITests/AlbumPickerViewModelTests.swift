//
//  AlbumPickerViewModelTests.swift
//  iTunesAPITests
//
//  Created by Yevhen Kharytonenko on 2/15/19.
//  Copyright © 2019 Yevhen Kharytonenko. All rights reserved.
//

import XCTest
@testable import iTunesAPI

class AlbumPickerViewModelTests: XCTestCase {

  let viewModel = AlbumPickerViewModel()

  override func setUp() {
    super.setUp()
  }

  func testEmptyInitialization() {
    XCTAssertEqual(viewModel.albums.count, 0)
    XCTAssertEqual(viewModel.albumCoverViews.count, 0)
    XCTAssertNil(viewModel.albumDetailViewModel)
  }

  func testThatAlbumPickerViewModelCreatesAlbumDetailViewModel() {
    viewModel.albums.append(albumForTesting()!)
    viewModel.albumCoverViews.append(coverViewForTesting()!)
    viewModel.selectedAlbumIndex = 0

    let detailViewModel = viewModel.albumDetailViewModel
    XCTAssertNotNil(detailViewModel)
  }

  func albumForTesting() -> Album? {
    if let path = Bundle(for: AlbumPickerViewModelTests.self).path(forResource: "TestAlbum", ofType: "json") {
      do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let album = try iso8601JSONDecoder().decode(Album.self, from: data)
        return album
      } catch {

      }
    }
    return nil
  }

  func coverViewForTesting() -> AlbumCoverView? {
    return Bundle.main.loadNibNamed(String(describing: AlbumCoverView.self),owner: nil)?.first as? AlbumCoverView
  }
}
