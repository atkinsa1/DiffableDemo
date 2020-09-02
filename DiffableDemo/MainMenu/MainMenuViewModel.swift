//
//  MainMenuViewModel.swift
//  DiffableDemo
//
//  Created by A452733 on 8/26/20.
//

import Combine
import UIKit

final class MainMenuViewModel {
  typealias SnapshotType = NSDiffableDataSourceSnapshot<MainMenuSection, MainMenuItem>

  private var cancellables = [AnyCancellable]()
  private weak var navigator: Navigator?

  private lazy var configuration: MainMenuConfiguration = {
    MainMenuConfiguration()
  }()

  private var dataSource: MainMenuDataSource?

  var snapshot: SnapshotType {
    var snapshot = SnapshotType()
    snapshot.appendSections([.mainMenu])
    snapshot.appendItems([.grid, .articles])

    return snapshot
  }

  init(navigator: Navigator?) {
    self.navigator = navigator
  }

  func configureCollectionView(_ collectionView: UICollectionView) {
    dataSource = configuration.dataSource(for: collectionView)
    collectionView.dataSource = dataSource

    dataSource?.apply(snapshot)
  }

  func selectItem(at indexPath: IndexPath) {
    if let item = dataSource?.itemIdentifier(for: indexPath) {

      switch item {
      case .grid:
        let viewModel = GridViewModel()
        let vc = GridViewController(viewModel: viewModel)
        navigator?.pushViewController(vc, animated: true)
      case .articles:
        let viewModel = ArticlesViewModel()
        let vc = ArticlesViewController(viewModel: viewModel)
        navigator?.pushViewController(vc, animated: true)
      }
    }
  }
}
