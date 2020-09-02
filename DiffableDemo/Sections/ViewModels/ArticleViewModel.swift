//
//  ArticleViewModel.swift
//  DiffableDemo
//
//  Created by A452733 on 8/31/20.
//

import Foundation

protocol ArticleViewModelType: Hashable {
  var type: Article.ArticleType { get }
  var title: String { get }
  var image: String { get }
}

struct ArticleViewModel: ArticleViewModelType {
  let type: Article.ArticleType
  let title: String
  let image: String
}
