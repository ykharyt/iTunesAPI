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

  var viewModel: AlbumPickerViewModelType?

  override func awakeFromNib() {
    super.awakeFromNib()
    bind(AlbumPickerViewModel())
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    guard let viewModel = viewModel else { return }
    viewModel.startDownloading { [weak self] in
      self?.albumPageControl.numberOfPages = viewModel.albumsCount
    }
  }

  func bind(_ viewModel: AlbumPickerViewModelType) {
    self.viewModel = viewModel
  }
}

