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
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let destinationViewController = segue.destination as? AlbumPickerViewController,
    let viewModel = destinationViewController.viewModel?.albumDetailViewModel else { return }

    titleLabel.text = viewModel.albumTitle
    descriptionLabel.text = viewModel.albumDescription
    cover.image = viewModel.albumCoverImage
  }
}
