//
//  MainCell.swift
//  CollectionView+Combine
//
//  Created by openobject on 2023/02/22.
//

import UIKit

class MainCell: UICollectionViewCell {
  static let identifier = "MainCell"
  var image: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .systemPink
    imageView.image = UIImage(named: "string")
    return imageView
  }()
  
  var name: UILabel = {
    let label = UILabel()
    label.text = "Name"
    label.textColor = .black
    return label
  }()
  
  var desc: UILabel = {
    let label = UILabel()
    label.text = "description"
    label.textColor = .systemGray6
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
    self.addSubview(image)
    self.addSubview(name)
    self.addSubview(desc)
    self.backgroundColor = .white
  }
  
  private func setConstraints() {
    image.snp.makeConstraints {
      $0.leading.top.bottom.equalToSuperview().inset(10)
      $0.width.equalTo(self.snp.height)
    }
    
    name.snp.makeConstraints {
      $0.leading.equalTo(image.snp.trailing).offset(10)
      $0.top.trailing.equalToSuperview().inset(10)
      $0.height.equalTo(30)
    }
    
    desc.snp.makeConstraints {
      $0.leading.equalTo(image.snp.trailing).offset(10)
      $0.bottom.trailing.equalToSuperview().inset(10)
      $0.top.equalTo(name.snp.bottom).offset(10)
    }
  }
}





