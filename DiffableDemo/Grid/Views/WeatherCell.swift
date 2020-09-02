//
//  WeatherCell.swift
//  DiffableDemo
//
//  Created by A452733 on 8/27/20.
//

import UIKit

class WeatherCell: UICollectionViewCell {
  @IBOutlet var background: UIView! {
    didSet {
      background.layer.cornerRadius = 8
      background.layer.borderWidth = 1
      background.layer.borderColor = UIColor.secondarySystemBackground.cgColor
    }
  }
  @IBOutlet var imageView: UIImageView!

  func configure(with viewModel: GridItemViewModel) {
    imageView.image = UIImage(systemName: viewModel.image) ?? UIImage()
    imageView.tintColor = viewModel.color
  }
}
