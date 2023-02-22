//
//  MainCell.swift
//  CollectionView+Combine
//
//  Created by openobject on 2023/02/22.
//

import UIKit

class MainCell: UICollectionViewCell {
  static let identifier = "MainCell"
  
  var cellNum: UILabel = {
    var label = UILabel()
    label.text = (0...50).map{ String($0) }.randomElement()!
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUI()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    super.init(coder: coder)
    setUI()
    setConstraints()
  }
  
  
  private func setUI() {
    self.addSubview(cellNum)
    self.backgroundColor = .white
  }
  
  private func setConstraints() {
    cellNum.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
}


