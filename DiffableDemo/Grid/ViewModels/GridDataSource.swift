//
//  GridDataSource.swift
//  DiffableDemo
//
//  Created by A452733 on 8/27/20.
//

import UIKit

typealias GridDataSource = UICollectionViewDiffableDataSource<GridSection, GridItem>

enum GridSection {
  case grid
}

enum GridItem: Hashable {
  case weather(id: UUID, viewModel: GridItemViewModel)
}

final class GridConfiguration {
  private typealias GridCellRegistration = UICollectionView.CellRegistration<WeatherCell, GridItem>

  private lazy var gridCell: GridCellRegistration = {
    let nib = UINib(nibName: "WeatherCell", bundle: nil)
    return GridCellRegistration(cellNib: nib) { (cell, indexPath, item) in
      switch item {
      case .weather(_, let viewModel):
        cell.configure(with: viewModel)
      }
    }
  }()

  func dataSource(for collectionView: UICollectionView) -> GridDataSource {
    GridDataSource(collectionView: collectionView) { (_, indexPath, item) -> UICollectionViewCell? in
      collectionView.dequeueConfiguredReusableCell(using: self.gridCell, for: indexPath, item: item)
    }
  }

  func layout() -> UICollectionViewLayout {
    // Item
    let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(50), heightDimension: .estimated(50))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    // Group
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                           heightDimension: .estimated(50))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 4)

    // Section
    let section = NSCollectionLayoutSection(group: group)
    return UICollectionViewCompositionalLayout(section: section)
  }
}
