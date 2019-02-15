//
//  Album+Helpers.swift
//  iTunesAPI
//
//  Created by Yevhen Kharytonenko on 2/15/19.
//  Copyright © 2019 Yevhen Kharytonenko. All rights reserved.
//

import UIKit

extension Album {

  func formattedShortDescription() -> String {
    return """
    Artist name: \(self.artistName)
    Copyright: \(self.copyright ?? "")
    """
  }

  func formattedLongDescription() -> String {
    return """
    Artist name: \(self.artistName)
    Genre: \(self.primaryGenreName)
    Tracks: \(self.trackCount ?? 0)
    Copyright: \(self.copyright ?? "")
    """
  }

  func artworkURLWithHigherResulution() -> String? {
    guard let lowResulutionURL = artworkUrl60 else { return nil }
    return lowResulutionURL.replacingOccurrences(of: "60x60", with: "600x600")
  }
}
