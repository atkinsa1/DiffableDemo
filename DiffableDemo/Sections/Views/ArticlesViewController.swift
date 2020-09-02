//
//  ArticlesViewController.swift
//  DiffableDemo
//
//  Created by A452733 on 8/31/20.
//

import UIKit

class ArticlesViewController: UIViewController {
  @IBOutlet var collectionView: UICollectionView!

  var viewModel: ArticlesViewModel

  init(viewModel: ArticlesViewModel) {
    self.viewModel = viewModel
    super.init(nibName: "ArticlesViewController", bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel.configureCollectionView(collectionView)
    viewModel.loadData()
  }

}
