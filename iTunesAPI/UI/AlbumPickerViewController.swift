//
//  ViewController.swift
//  iTunesAPI
//
//  Created by Yevhen Kharytonenko on 2/13/19.
//  Copyright © 2019 Yevhen Kharytonenko. All rights reserved.
//

import UIKit

class AlbumPickerViewController: UIViewController, UIScrollViewDelegate {

  @IBOutlet weak var albumScrollView: UIScrollView!
  @IBOutlet weak var albumPageControl: UIPageControl!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!

  var viewModel = AlbumPickerViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.getAlbums { [weak self] in
      guard let albums = self?.viewModel.albums,
        let albumCovers = self?.albumCoverViewsFrom(albums) else { return }
      self?.albumPageControl.numberOfPages = albums.count
      self?.setupSlideScrollView(coverViews: albumCovers)
    }
  }

  // MARK: - Actions

  @IBAction func pageControlSelectionAction(_ sender: UIPageControl) {
    scrollToAlbum(sender.currentPage)
  }

  // MARK: - UIScrollViewDelegate

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    selectAlbum(Int(round(scrollView.contentOffset.x/view.frame.width)))
  }

  // MARK: - Helpers

  func scrollToAlbum(_ index: Int) {
    albumScrollView.setContentOffset(CGPoint(x: view.frame.width * CGFloat(index), y: 0), animated: true)
  }

  func selectAlbum(_ index: Int) {
    guard index < viewModel.albums.count else { return }
    albumPageControl.currentPage = index
    let album = viewModel.albums[index]
    titleLabel.text = album.collectionName
  }

  func albumCoverViewsFrom(_ albums: [Album]) -> [AlbumCoverView] {
    var builder = [AlbumCoverView]()
    for album in albums {
      let coverView = Bundle.main.loadNibNamed(
        "AlbumCoverView",
        owner: self,
        options: nil)?.first as! AlbumCoverView
      if let link = album.artworkUrl100 {
        coverView.albumImage.setImageDownloaded(link)
      }
      builder.append(coverView)
    }
    return builder
  }

  func setupSlideScrollView(coverViews: [AlbumCoverView]) {
    albumScrollView.contentSize = CGSize(
      width: albumScrollView.frame.width * CGFloat(coverViews.count),
      height: albumScrollView.frame.height
    )
    albumScrollView.isPagingEnabled = true

    for i in 0 ..< coverViews.count {
      coverViews[i].frame = CGRect(
        x: albumScrollView.frame.width * CGFloat(i),
        y: 0,
        width: albumScrollView.frame.width,
        height: albumScrollView.frame.height
      )
      albumScrollView.addSubview(coverViews[i])
    }
  }
}

