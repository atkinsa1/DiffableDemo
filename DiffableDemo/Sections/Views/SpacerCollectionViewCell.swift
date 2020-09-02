//
//  SpacerCollectionViewCell.swift
//  DiffableDemo
//
//  Created by A452733 on 8/31/20.
//

import UIKit

final class SpacerCollectionViewCell: UICollectionViewCell {
  private var horizontalConstraint: NSLayoutConstraint?
  private var verticalConstraint: NSLayoutConstraint?

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(size: CGSize) {
    horizontalConstraint?.isActive = false
    verticalConstraint?.isActive = false
    horizontalConstraint = widthAnchor.constraint(equalToConstant: size.width)
    verticalConstraint = heightAnchor.constraint(equalToConstant: size.height)
    NSLayoutConstraint.activate([horizontalConstraint!, verticalConstraint!])
  }
}
