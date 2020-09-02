//
//  Article.swift
//  DiffableDemo
//
//  Created by A452733 on 8/31/20.
//

import Foundation

struct Article {
  enum ArticleType {
    case food, drink
  }

  let featured: Bool
  let type: ArticleType
  let title: String
  let image: String
}
