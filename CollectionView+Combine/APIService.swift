//
//  APIService.swift
//  CollectionView+Combine
//
//  Created by openobject on 2023/02/22.
//

import Foundation
import Combine

import Alamofire

class APIService {
  let API_KEY = "k_xksqp4v2"
  let BASE_URL = "https://imdb-api.com/en/API/SearchMovie/"
  
  static let shared = APIService()
  var cancellable: AnyCancellable?
  
  func fetchMovies(of keyword: String) -> AnyPublisher<[Movies], Never> {
    guard let url = URL(string: BASE_URL + API_KEY + "/" + keyword) else { return Just([]).eraseToAnyPublisher() }
    
    print(url)
    
    return Future() { promise in
      self.cancellable = AF.request(url)
        .publishDecodable(type: Result.self)
        .value()
        .sink { completion in
          switch completion{
          case .finished:
            print("fetchMovies finished")
          case .failure(let error):
            print("fetchMovies error: \(error)")
          }
          self.cancellable?.cancel()
        } receiveValue: { result in
          promise(.success(result.results))
        }
    }
    .eraseToAnyPublisher()
  }

}
