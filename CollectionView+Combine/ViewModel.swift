//
//  ViewModel.swift
//  CollectionView+Combine
//
//  Created by openobject on 2023/02/22.
//

import UIKit
import Combine

class ViewModel {
  var cancellables = Set<AnyCancellable>()
  @Published var keyword: String = ""
  
  var diffableDataSource: MoviesCollectionViewDiffableDataSource!
  var snapshot = NSDiffableDataSourceSnapshot<String?, Movies>()
  
  init() {
      $keyword.receive(on: RunLoop.main)
      .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
      .sink { (_) in
        self.searchMovies()
      }.store(in: &cancellables)
  }
      

  func searchMovies() {
    APIService.shared.fetchMovies(of: keyword)
      .sink { completion in
        switch completion {
        case .finished:
          print("ViewModel searchMovies finished")
        case .failure:
          print("ViewModel searchMovies failure")
        }
      } receiveValue: { movies in
        self.snapshot.deleteAllItems()
        self.snapshot.appendSections([""])
        
        if movies.isEmpty {
          self.diffableDataSource.apply(self.snapshot, animatingDifferences: true)
          return 
        }
        self.snapshot.appendItems(movies)
        self.diffableDataSource.apply(self.snapshot, animatingDifferences: true)
      }
      .store(in: &cancellables)
  }
}
