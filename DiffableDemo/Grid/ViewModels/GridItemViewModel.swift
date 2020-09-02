//
//  GridItem.swift
//  DiffableDemo
//
//  Created by A452733 on 8/27/20.
//

import UIKit

struct GridItemViewModel: Hashable {
  var image: String
  var color: UIColor
}

extension Weather {
  var image: String {
    switch type {
    case .heavyRain:
      return "cloud.heavyrain.fill"
    case .snow:
      return "cloud.snow.fill"
    case .lightning:
      return "cloud.bolt.fill"
    case .partialCloud:
      return "cloud.sun.fill"
    case .sun:
      return "sun.max.fill"
    }
  }

  var color: UIColor {
    switch type {
    case .heavyRain:
      return .darkGray
    case .snow:
      return .cyan
    case .lightning:
      return .magenta
    case .partialCloud:
      return .lightGray
    case .sun:
      return .yellow
    }
  }
}
