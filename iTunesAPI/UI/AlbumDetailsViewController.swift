//
//  AlbumDetailsViewController.swift
//  iTunesAPI
//
//  Created by Yevhen Kharytonenko on 2/15/19.
//  Copyright © 2019 Yevhen Kharytonenko. All rights reserved.
//

import UIKit

class AlbumDetailsViewController: UIViewController {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var cover: UIImageView!

  var viewModel: AlbumDetailViewModelType?

  override func viewDidLoad() {
    super.viewDidLoad()

    titleLabel.text = viewModel?.albumTitle
    descriptionLabel.text = viewModel?.albumDescription
    cover.image = viewModel?.albumCoverImage
  }
}
