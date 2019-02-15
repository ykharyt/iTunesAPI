//
//  iTunesAPIRequest.swift
//  iTunesAPI
//
//  Created by Yevhen Kharytonenko on 2/13/19.
//  Copyright © 2019 Yevhen Kharytonenko. All rights reserved.
//

import UIKit

enum iTunesAPIRequestResult<T> {
  case value(T)
  case error(description: String)
}

enum iTunesAPIRequest {
  case lookupAlbum(artistId: Int)

  struct Constants {
    static let baseURL = URL(string: "https://itunes.apple.com/")
  }

  private func requestURL() -> URL? {
    switch self {
    case .lookupAlbum(let artistId):
      let parameters = [
        "id": String(artistId),
        "entity": "album",
        "limit": "10"
      ]
      let combinderParameters = parameters.compactMap { "\($0.key)=\($0.value)" }.joined(separator: "&")
      return URL(string: "lookup?" + combinderParameters, relativeTo: Constants.baseURL)
    }
  }

  func perform<T: Decodable>(with completion: @escaping (iTunesAPIRequestResult<T>) -> ()) {
    guard let requestURL = requestURL() else {
      completion(.error(description: "Can't create request URL"))
      return
    }
    URLSession(configuration: .default)
      .dataTask(with: requestURL, completionHandler: { data, response, error in
        guard let httpResponse = response as? HTTPURLResponse else {
          completion(.error(description: "Can't parse response data"))
          return
        }
        if httpResponse.statusCode == 200 {
          if let data = data,
            let response = try? iso8601JSONDecoder().decode(T.self, from: data) {
            completion(.value(response))
          } else {
            completion(.error(description: "Can't decode the response"))
          }
        } else {
          completion(.error(description: "Failed to perform request. Status code: \(httpResponse.statusCode)"))
        }
      }).resume()
  }
}
