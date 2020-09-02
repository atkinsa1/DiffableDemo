//
//  HeaderReusableView.swift
//  DiffableDemo
//
//  Created by A452733 on 8/31/20.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {

  @IBOutlet var label: UILabel!

  func configure(text: String) {
    label.text = text
  }
    
}
