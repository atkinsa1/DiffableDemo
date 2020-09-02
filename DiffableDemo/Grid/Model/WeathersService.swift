//
//  WeathersModel.swift
//  DiffableDemo
//
//  Created by A452733 on 8/27/20.
//

import Combine
import UIKit

struct WeathersService {
  private var weathersSubject = CurrentValueSubject<[Weather], Never>([])
  public var weathers: AnyPublisher<[Weather], Never> {
    weathersSubject
      .debounce(for: .seconds(1), scheduler: RunLoop.main)
      .eraseToAnyPublisher()
  }

  public func addItem() {
    var items = weathersSubject.value
    let newItem = Weather(type: Weather.WeatherType.allCases.randomElement() ?? .sun)
    items.insert(newItem, at: Int.random(in: 0...items.count))
    weathersSubject.send(items)
  }

  // Remove a random weather from our model
  public func removeItem() {
    var items = weathersSubject.value
    guard items.count > 0 else { return }
    items.remove(at: Int.random(in: 0..<items.count))
    weathersSubject.send(items)
  }
}
