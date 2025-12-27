//
//  JSONLoader.swift
//  Parla
//
//  Created by Konstantin Safronov on 26.12.2025.
//

import Foundation

protocol JSONLoading {
  func load<T: Decodable>(_ filename: String) throws -> T
}

final class JSONLoader: JSONLoading {
  func load<T: Decodable>(_ filename: String) throws -> T {
    guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
      throw NSError(domain: "File not found", code: 404)
    }
    
    let data = try Data(contentsOf: url)
    let decoder = JSONDecoder()
    return try decoder.decode(T.self, from: data)
  }
}
