//
//  GridViewModel.swift
//  DiffableDemo
//
//  Created by A452733 on 8/26/20.
//

import UIKit
import Combine

final class GridViewModel {
  typealias SnapshotType = NSDiffableDataSourceSnapshot<GridSection, GridItem>

  private var cancellables = [AnyCancellable]()

  private lazy var configuration: GridConfiguration = {
    GridConfiguration()
  }()
  private var dataSource: GridDataSource?

  // This is our model (ie data from a service)
  private var service = WeathersService()

  private var snapshotSubject = PassthroughSubject<SnapshotType, Never>()
  public var snapshot: AnyPublisher<SnapshotType, Never> {
    snapshotSubject.eraseToAnyPublisher()
  }

  init() {
    service.weathers
      .map { self.snapshot(for: $0) }
      .subscribe(snapshotSubject)
      .store(in: &cancellables)

    snapshotSubject
      .receive(on: RunLoop.main)
      .sink { [weak self] snapshot in
        self?.dataSource?.apply(snapshot)
      }
      .store(in: &cancellables)
  }

  public func configureCollectionView(_ collectionView: UICollectionView) {
    dataSource = configuration.dataSource(for: collectionView)
    collectionView.dataSource = dataSource
    collectionView.setCollectionViewLayout(configuration.layout(), animated: false)
  }

  // Ask service to add an item
  public func addItem() {
    service.addItem()
  }

  // Ask service to remove an item
  public func removeItem() {
    service.removeItem()
  }

  // Generate a snapshot from our model
  private func snapshot(for weathers: [Weather]) -> SnapshotType {
    var snapshot = SnapshotType()

    snapshot.appendSections([.grid])

    let items: [GridItem] = weathers.map { weather in
      let viewModel = GridItemViewModel(image: weather.image, color: weather.color)
      return .weather(id: weather.id, viewModel: viewModel)
    }

    snapshot.appendItems(items)

    return snapshot
  }
}
