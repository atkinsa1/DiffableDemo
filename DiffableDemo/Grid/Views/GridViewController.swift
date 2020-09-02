//
//  GridViewController.swift
//  DiffableDemo
//
//  Created by A452733 on 8/26/20.
//

import UIKit

class GridViewController: UIViewController {
  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet var addButton: UIButton!
  @IBOutlet var deleteButton: UIButton!
  
  private var viewModel: GridViewModel
  
  init(viewModel: GridViewModel) {
    self.viewModel = viewModel
    super.init(nibName: "GridViewController", bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    addButton.addAction(UIAction { [viewModel] _ in
      viewModel.addItem()
    }, for: .touchUpInside)

    deleteButton.addAction(UIAction { [viewModel] _ in
      viewModel.removeItem()
    }, for: .touchUpInside)

    viewModel.configureCollectionView(collectionView)
  }

}
