//
//  MainViewController.swift
//  DiffableDemo
//
//  Created by A452733 on 8/24/20.
//

import UIKit

class MainViewController: UICollectionViewController {
  private var viewModel: MainMenuViewModel?

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Diffable Datasources Demo"

    viewModel = MainMenuViewModel(navigator: navigationController)

    let listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
    let layout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
    collectionView.setCollectionViewLayout(layout, animated: false)

    viewModel?.configureCollectionView(collectionView)
  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel?.selectItem(at: indexPath)
  }
}
