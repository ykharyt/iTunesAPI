//
//  WebImageView.swift
//  iTunesAPI
//
//  Created by Yevhen Kharytonenko on 2/14/19.
//  Copyright © 2019 Yevhen Kharytonenko. All rights reserved.
//

import UIKit

class WebImageView: UIImageView {

  func setImageDownloaded(_ url: URL, contentMode mode: UIView.ContentMode = .scaleToFill) {
    contentMode = mode
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard
        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
        let data = data, error == nil,
        let image = UIImage(data: data)
        else { return }
      DispatchQueue.main.async() { self.image = image }
      }.resume()
  }

  func setImageDownloaded(_ link: String, contentMode mode: UIView.ContentMode = .scaleToFill) {
    guard let url = URL(string: link) else { return }
    setImageDownloaded(url, contentMode: mode)
  }
}
