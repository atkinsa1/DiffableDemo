//
//  GridItem.swift
//  DiffableDemo
//
//  Created by A452733 on 8/27/20.
//

import UIKit

var gridImages = ["cloud.heavyrain.fill", "cloud.snow.fill", "cloud.bolt.fill", "cloud.sun.fill", "sun.max.fill"]
var gridColors: [UIColor] = [.blue, .brown, .red, .cyan, .yellow, .darkGray, .magenta, .orange]

struct GridItemViewModel {
  var id = UUID()
  var image: String
  var color: UIColor

  static func random() -> GridItemViewModel {
    let image = gridImages.randomElement() ?? "sun.max.fill"
    let color = gridColors.randomElement() ?? .black
    return GridItemViewModel(image: image, color: color)
  }
}
