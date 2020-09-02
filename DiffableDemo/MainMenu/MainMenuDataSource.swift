//
//  MainMenuDataSource.swift
//  DiffableDemo
//
//  Created by A452733 on 8/25/20.
//

import UIKit

typealias MainMenuDataSource = UICollectionViewDiffableDataSource<MainMenuSection, MainMenuItem>

enum MainMenuSection {
  case mainMenu
}

enum MainMenuItem {
  case grid
  case articles
}

extension MainMenuItem {
  var label: String? {
    switch self {
    case .grid:
      return "Grid demo"
    case .articles:
      return "Articles demo"
    }
  }
}

final class MainMenuConfiguration {
  private typealias MainCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, MainMenuItem>

  private lazy var mainCell = {
    MainCellRegistration { (cell, indexPath, item) in
      var config = cell.defaultContentConfiguration()
      config.text = item.label
      config.image = UIImage(systemName: "gear")
      cell.tintColor = .systemGray
      cell.accessories = [.disclosureIndicator(options: .init(tintColor: .systemGray))]
      cell.contentConfiguration = config
    }
  }()

  func dataSource(for collectionView: UICollectionView) -> MainMenuDataSource {
    MainMenuDataSource(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
      collectionView.dequeueConfiguredReusableCell(using: self.mainCell, for: indexPath, item: item)
    }
  }
}
