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

  var viewModel: AlbumPickerViewModelType?

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel = AlbumPickerViewModel()

    viewModel?.downloadAlbums { [weak self] in
      guard let viewModel = self?.viewModel else { return }
      let albumCovers = viewModel.albumCoverViews
      self?.albumPageControl.numberOfPages = albumCovers.count
      self?.setupSlideScrollView(coverViews: albumCovers)
      self?.selectAlbum(0)
    }
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let destinationViewController = segue.destination as? AlbumDetailsViewController else { return }
    destinationViewController.viewModel = viewModel?.albumDetailViewModel
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
    let point = CGPoint(x: view.frame.width * CGFloat(index), y: 0)
    albumScrollView.setContentOffset(point, animated: true)
  }

  func selectAlbum(_ index: Int) {
    guard var viewModel = viewModel,
      index < viewModel.albums.count,
      index != viewModel.selectedAlbumIndex else { return }
    albumPageControl.currentPage = index

    let album = viewModel.albums[index]
    titleLabel.text = album.collectionName
    descriptionLabel.text = album.formattedShortDescription()
    viewModel.selectedAlbumIndex = index
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

