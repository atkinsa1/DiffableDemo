//
//  Weather.swift
//  DiffableDemo
//
//  Created by A452733 on 8/27/20.
//

import Foundation

struct Weather {
  enum WeatherType: CaseIterable {
    case heavyRain, snow, lightning, partialCloud, sun
  }
  
  var id = UUID()
  var type: WeatherType
}


