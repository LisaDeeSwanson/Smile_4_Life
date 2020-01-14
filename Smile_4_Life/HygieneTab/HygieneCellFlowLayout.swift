//
//  HygieneCellFlowLayout.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 10/28/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import UIKit

class HygieneCellFlowLayout: UICollectionViewFlowLayout {
  
  
  var numberOfRows: CGFloat = 3
  
  init(numberOfRows: CGFloat) {
    super.init()
    self.numberOfRows = numberOfRows
    self.minimumLineSpacing = 1
    self.minimumInteritemSpacing = 0
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var itemSize: CGSize {
    get {
      if let collectionView = collectionView {
        let collectionViewWidth = collectionView.frame.width
        let collectionViewHeight = collectionView.frame.height
        let itemWidth = (collectionViewWidth - 4) / 7
        let itemHeight = (collectionViewHeight - 5 - self.minimumLineSpacing) / numberOfRows

        return CGSize(width: itemWidth, height: itemHeight)
      }
      return CGSize(width: 45, height: 45)
    }
    set {
      super.itemSize = newValue
    }
  }

}



