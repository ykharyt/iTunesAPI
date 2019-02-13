//
//  ViewController.swift
//  iTunesAPI
//
//  Created by Yevhen Kharytonenko on 2/13/19.
//  Copyright © 2019 Yevhen Kharytonenko. All rights reserved.
//

import UIKit

class AlbumPickerViewController: UIViewController {

  @IBOutlet weak var albumPageControl: UIPageControl!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!

  var viewModel = AlbumPickerViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.startDownloading { [weak self] in
      guard let count = self?.viewModel.albumsCount else { return }
      self?.albumPageControl.numberOfPages = count
    }
  }

  @IBAction func pageControlSelectionAction(_ sender: UIPageControl) {
    if let album = viewModel.album(at: sender.currentPage) {
      titleLabel.text = album.collectionName
    }
  }
}

