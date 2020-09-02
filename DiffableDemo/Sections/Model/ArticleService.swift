//
//  ArticleService.swift
//  DiffableDemo
//
//  Created by A452733 on 8/31/20.
//

import Combine
import UIKit

final class ArticleService {
  private var foodsSubject = CurrentValueSubject<[Article], Never>([])
  public var foods: AnyPublisher<[Article], Never> {
    foodsSubject
      .eraseToAnyPublisher()
  }

  private var drinksSubject = CurrentValueSubject<[Article], Never>([])
  public var drinks: AnyPublisher<[Article], Never> {
    drinksSubject
      .eraseToAnyPublisher()
  }

  func fetchFoods() {
    let mockFoods = [
      Article(featured: true, type: .food, title: "Hamburger", image: "rectangle"),
      Article(featured: false, type: .food, title: "Apple", image: "circle"),
      Article(featured: false, type: .food, title: "Cheese", image: "triangle"),
      Article(featured: false, type: .food, title: "Tortoise", image: "tortoise")
    ]
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {
      self.foodsSubject.send(mockFoods)
    }
  }

  func fetchDrinks() {
    let mockDrinks = [
      Article(featured: false, type: .drink, title: "Coke", image: "trash"),
      Article(featured: false, type: .drink, title: "Water", image: "drop.triangle"),
      Article(featured: false, type: .drink, title: "Scissors", image: "scissors"),
      Article(featured: false, type: .drink, title: "Hammers", image: "hammer")
    ]
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
      self.drinksSubject.send(mockDrinks)
    }
  }
}
