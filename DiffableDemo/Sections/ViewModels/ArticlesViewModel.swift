//
//  ArticlesViewModel.swift
//  DiffableDemo
//
//  Created by A452733 on 8/31/20.
//

import Combine
import UIKit

final class ArticlesViewModel {
  typealias SnapshotType = NSDiffableDataSourceSnapshot<ArticlesSection, ArticlesItem>

  private lazy var configuration: ArticlesConfiguration = {
    ArticlesConfiguration()
  }()

  private var cancellables = [AnyCancellable]()
  private var dataSource: ArticlesDataSource?
  private var service = ArticleService()

  private var snapshotSubject = PassthroughSubject<SnapshotType, Never>()
  public var snapshot: AnyPublisher<SnapshotType, Never> {
    snapshotSubject.eraseToAnyPublisher()
  }
  
  init() {
    Publishers.CombineLatest(service.foods, service.drinks)
      .map { (foods, drinks) -> SnapshotType in
        self.snapshot(foods: foods, drinks: drinks)
      }
      .subscribe(snapshotSubject)
      .store(in: &cancellables)

    snapshotSubject
      .receive(on: DispatchQueue.main)
      .sink { [weak self] snapshot in
        self?.dataSource?.apply(snapshot)
      }
      .store(in: &cancellables)
  }

  
  public func configureCollectionView(_ collectionView: UICollectionView) {
    let dataSource = configuration.dataSource(for: collectionView)
    collectionView.dataSource = dataSource
    collectionView.setCollectionViewLayout(configuration.layout(for: dataSource), animated: false)
    self.dataSource = dataSource
  }

  func loadData() {
    dataSource?.apply(snapshot(foods: [], drinks: []))
    service.fetchFoods()
    service.fetchDrinks()
  }

  func snapshot(foods: [Article], drinks: [Article]) -> SnapshotType {
    var snapshot = SnapshotType()

    snapshot.appendSections([.food])

    if foods.isEmpty {
      snapshot.appendItems([.loading(.food)])
    } else {
      let foodItems: [ArticlesItem] = foods.map { article in
        let viewModel = ArticleViewModel(type: .food,
                                         title: article.title,
                                         image: article.image)
        return article.featured ? .featuredArticle(viewModel) : .article(viewModel)
      }
      snapshot.appendItems(foodItems)
      snapshot.appendItems([.spacer(.init(width: 1, height: 80))])
    }

    snapshot.appendSections([.drink])
    if drinks.isEmpty {
      snapshot.appendItems([.loading(.drink)])
    } else {
      let drinkItems: [ArticlesItem] = drinks.map { .featuredArticle(ArticleViewModel(type: .drink,
                                                                                      title: $0.title,
                                                                                      image: $0.image)) }
      snapshot.appendItems(drinkItems)
    }

    return snapshot
  }
}
