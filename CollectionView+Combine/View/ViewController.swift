//
//  ViewController.swift
//  CollectionView+Combine
//
//  Created by openobject on 2023/02/22.
//

import UIKit
import Combine
import SnapKit

class ViewController: UIViewController {
  let searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.placeholder = "검색어 입력"
    searchBar.searchBarStyle = .minimal
    searchBar.layer.cornerRadius = 20
    searchBar.layer.borderWidth = 1
    return searchBar
  }()
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = .cyan
    return cv
  }()
  
  @Published var keyStroke: String = ""
  var cancellables = Set<AnyCancellable>()
  
  var viewModel = ViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self
    
    configureCollectionView()
    setupObservers()
    
  }

  private func addViews() {
    self.view.addSubview(searchBar)
    self.view.addSubview(collectionView)
  }
  
  private func configureCollectionView() {
    addViews()
    
    collectionView.register(MainCell.self, forCellWithReuseIdentifier: MainCell.identifier)
    collectionView.collectionViewLayout = createContentLayout()
    setupLayout()
  }
  
  private func setupLayout() {
    searchBar.snp.makeConstraints{
      $0.width.equalToSuperview()
      $0.height.equalTo(50)
      $0.centerX.equalToSuperview()
      $0.top.equalTo(view.safeAreaLayoutGuide)
    }
    
    collectionView.snp.makeConstraints{
      $0.width.height.equalToSuperview()
      $0.centerX.equalToSuperview()
      $0.top.equalTo(searchBar.snp.bottom).offset(10)
    }
  }
  
  
  private func createContentLayout() -> UICollectionViewLayout {
    let layout: UICollectionViewCompositionalLayout = {
      let itemSpacing: CGFloat = 10
      let width: CGFloat = 1.0
      let height: CGFloat = 1.0 / 6.0
      
      // item
      let itemSize = NSCollectionLayoutSize (
        widthDimension: .fractionalWidth(width),
        heightDimension: .fractionalHeight(1)
      )
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.contentInsets = NSDirectionalEdgeInsets(top: itemSpacing, leading: itemSpacing, bottom: itemSpacing, trailing: itemSpacing)
      
      // Group
      let groupSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1),
        heightDimension: .fractionalHeight(height)
      )
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      
      // Section
      let section = NSCollectionLayoutSection(group: group)
      section.contentInsets = NSDirectionalEdgeInsets(top: itemSpacing, leading: itemSpacing, bottom: itemSpacing, trailing: itemSpacing)
      
      return UICollectionViewCompositionalLayout(section: section)
    }()
    
    return layout
  }
  
  
  func setupObservers() {
    $keyStroke
      .receive(on: RunLoop.main)
      .sink { keyword in
        print(keyword)
        self.viewModel.keyword = keyword
      }
      .store(in: &cancellables)
    
    viewModel.diffableDataSource = MoviesCollectionViewDiffableDataSource(collectionView: collectionView) { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as? MainCell else { return UICollectionViewCell() }
      
      cell.movie = itemIdentifier
      return cell
    }
  }
  
}



extension ViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    self.keyStroke = searchText
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    self.keyStroke = ""
  }
}
