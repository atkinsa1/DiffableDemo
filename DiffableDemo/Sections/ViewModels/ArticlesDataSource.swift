//
//  ArticlesDataSource.swift
//  DiffableDemo
//
//  Created by A452733 on 8/31/20.
//

import Foundation
import UIKit

typealias ArticlesDataSource = UICollectionViewDiffableDataSource<ArticlesSection, ArticlesItem>

enum ArticlesSection: Hashable {
  case food
  case drink
}

enum ArticlesItem: Hashable {
  case loading(ArticlesSection)
  case spacer(CGSize)
  case featuredArticle(ArticleViewModel)
  case article(ArticleViewModel)
}

final class ArticlesConfiguration {
  typealias ArticleCellRegistration = UICollectionView.CellRegistration<ArticleCollectionViewCell, ArticlesItem>
  typealias SmallArticleCellRegistration = UICollectionView.CellRegistration<SmallArticleCollectionViewCell, ArticlesItem>
  typealias SpacerCellRegistration = UICollectionView.CellRegistration<SpacerCollectionViewCell, ArticlesItem>
  typealias LoadingCellRegistration = UICollectionView.CellRegistration<LoadingCollectionViewCell, ArticlesItem>
  typealias HeaderRegistration = UICollectionView.SupplementaryRegistration<HeaderReusableView>

  private lazy var articleCell: ArticleCellRegistration = {
    let nib = UINib(nibName: "ArticleCollectionViewCell", bundle: nil)
    return ArticleCellRegistration(cellNib: nib) { (cell, indexPath, item) in
      switch item {
      case .featuredArticle(let viewModel):
        cell.configure(viewModel: viewModel)
      case .article(let viewModel):
        cell.configure(viewModel: viewModel)
      default:
        fatalError("Can't configure ArticleCollectionViewCell")
      }
    }
  }()

  private lazy var smallArticleCell: SmallArticleCellRegistration = {
    let nib = UINib(nibName: "SmallArticleCollectionViewCell", bundle: nil)
    return SmallArticleCellRegistration(cellNib: nib) { (cell, indexPath, item) in
      switch item {
      case .featuredArticle(let viewModel):
        cell.configure(viewModel: viewModel)
      case .article(let viewModel):
        cell.configure(viewModel: viewModel)
      default:
        fatalError("Can't configure SmallArticleCollectionViewCell")
      }
    }
  }()

  private lazy var spacerCell: SpacerCellRegistration = {
    return SpacerCellRegistration { cell, _, item in
      if case let .spacer(size) = item {
        cell.configure(size: size)
      }
    }
  }()

  private lazy var loadingCell: LoadingCellRegistration = {
    let nib = UINib(nibName: "LoadingCollectionViewCell", bundle: nil)
    return LoadingCellRegistration(cellNib: nib) { _, _, _ in
      // cell doesnt need configuration
    }
  }()

  private lazy var headerSupplementary: HeaderRegistration = {
    let nib = UINib(nibName: "HeaderReusableView", bundle: nil)
    return HeaderRegistration(supplementaryNib: nib, elementKind: "header") { _, _, _ in
      // nothing to do
    }
  }()

  func dataSource(for collectionView: UICollectionView) -> ArticlesDataSource {
    let dataSource = ArticlesDataSource(collectionView: collectionView) { (collectionView, indexPath, item) in
      switch item {
      case .loading:
        return collectionView.dequeueConfiguredReusableCell(using: self.loadingCell, for: indexPath, item: item)
      case .spacer:
        return collectionView.dequeueConfiguredReusableCell(using: self.spacerCell, for: indexPath, item: item)
      case .featuredArticle:
        return collectionView.dequeueConfiguredReusableCell(using: self.articleCell, for: indexPath, item: item)
      case .article:
        return collectionView.dequeueConfiguredReusableCell(using: self.smallArticleCell, for: indexPath, item: item)
      }
    }

    dataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
      guard let item = dataSource.itemIdentifier(for: indexPath) else { return nil }
      guard let section = dataSource.snapshot().sectionIdentifier(containingItem: item) else { return nil }

      if kind == "header" {
        switch section {
        case .food, .drink:
          let view = collectionView.dequeueConfiguredReusableSupplementary(using: self.headerSupplementary, for: indexPath)
          view.configure(text: section.title)
          return view
        }
      }

      return nil
    }

    return dataSource
  }

  func layout(for dataSource: ArticlesDataSource) -> UICollectionViewLayout {
    let sectionProvider = { [weak dataSource] (index: Int, layoutEnvironment: NSCollectionLayoutEnvironment)
      -> NSCollectionLayoutSection? in

      guard let sections = dataSource?.snapshot().sectionIdentifiers, index < sections.count else {
        return nil
      }
      let section = sections[index]

      switch section {
      case .food:
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitem: item, count: 1)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: "header",
                                                                        alignment: .top)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.boundarySupplementaryItems = [sectionHeader]

        return section

      case .drink:
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(1), heightDimension: .estimated(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        group.interItemSpacing = .fixed(8)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: "header",
                                                                        alignment: .top)
        let sectionBackground = NSCollectionLayoutDecorationItem.background(elementKind: "background")
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        section.interGroupSpacing = 8
        section.boundarySupplementaryItems = [sectionHeader]
        section.decorationItems = [sectionBackground]

        return section
      }
    }
    let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    layout.register(UINib(nibName: "BackgroundReusableView", bundle: nil), forDecorationViewOfKind: "background")
    return layout
  }
}

extension ArticlesSection {
  var title: String {
    switch self {
    case .food:
      return "Food"
    case .drink:
      return "Drink"
    }
  }
}
