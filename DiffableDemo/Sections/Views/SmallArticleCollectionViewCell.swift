//
//  ArticleCollectionViewCell.swift
//  DiffableDemo
//
//  Created by A452733 on 8/31/20.
//

import UIKit

class SmallArticleCollectionViewCell: UICollectionViewCell {

  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var background: UIView! {
    didSet {
      background.layer.borderWidth = 1
      background.layer.borderColor = UIColor.darkGray.cgColor
      background.layer.cornerRadius = 6
    }
  }

  func configure(viewModel: ArticleViewModel) {
    titleLabel.text = viewModel.title
    imageView.image = UIImage(systemName: viewModel.image)
    background.layer.borderColor = viewModel.type == .food ? UIColor.red.cgColor : UIColor.blue.cgColor
  }
}
