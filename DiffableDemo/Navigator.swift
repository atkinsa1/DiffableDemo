//
//  Navigator.swift
//  DiffableDemo
//
//  Created by A452733 on 8/27/20.
//

import UIKit

protocol Navigator: AnyObject {
  func pushViewController(_ viewController: UIViewController, animated: Bool)
  func popViewController(animated: Bool) -> UIViewController?
}

extension UINavigationController: Navigator {}
