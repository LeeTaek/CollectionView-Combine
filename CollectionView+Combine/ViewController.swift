//
//  ViewController.swift
//  CollectionView+Combine
//
//  Created by openobject on 2023/02/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = .cyan
    return cv
  }()
  
  var dataSource: UICollectionViewDiffableDataSource<Int, Int>!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    configureCollectionView()
  }
  
  private func configureCollectionView() {
    self.view.addSubview(collectionView)
    
    collectionView.register(MainCell.self, forCellWithReuseIdentifier: "MainCell")
    collectionView.collectionViewLayout = createContentLayout()
    setUpDataSource()
    performCell()
    
    setupLayout()
  }
  
  private func setupLayout() {
    collectionView.snp.makeConstraints{
      $0.width.height.equalToSuperview()
      $0.center.equalToSuperview()
    }
  }
  
  
  private func setUpDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as? UICollectionViewCell else {
        return UICollectionViewCell()
      }
      
      return cell
    }
  }
  
  private func performCell() {
    let numOfCell: [Int] = (0..<10).map{ Int($0) }
    
    var snapShot = NSDiffableDataSourceSnapshot<Int, Int>()
    snapShot.appendSections([0])
    snapShot.appendItems(numOfCell)
    self.dataSource.apply(snapShot)
  }
  
  
  private func createContentLayout() -> UICollectionViewLayout {
    let layout: UICollectionViewCompositionalLayout = {
      let itemSpacing: CGFloat = 10
      let width: CGFloat = 1.0 / 2.0
      let height: CGFloat = 1.0 / 2.5
      
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
  
  
}



