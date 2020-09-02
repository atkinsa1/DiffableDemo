//
//  CGSize+Hashable.swift
//  DiffableDemo
//
//  Created by A452733 on 9/1/20.
//

import UIKit

extension CGSize: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(width)
    hasher.combine(height)
  }
}
