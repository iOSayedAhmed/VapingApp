//
//  Networking.swift
//  VapingApp
//
//  Created by iOSayed on 17/12/2022.
//

import Foundation

class Networking {
    static let shared = Networking()
    
    func FetchData(from urlString: String,
                        completion: @escaping (Result<Data, Error>) -> ()) {
      if let url = URL(string: urlString) {
          let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
              if let error = error {
                  completion(.failure(error))
              }
              if let data = data {
                  completion(.success(data))
              }
          }
          urlSession.resume()
      }
  }
    
}
