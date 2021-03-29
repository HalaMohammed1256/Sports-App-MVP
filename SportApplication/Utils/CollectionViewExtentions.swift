//
//  CollectionViewExtentions.swift
//  SportApplication
//
//  Created by AhmedFareed on 29/03/2021.
//

import Foundation
import UIKit

extension UICollectionView{
    func numberOfItemsIn(section : Int = 0) -> Int {
        return self.numberOfItems(inSection:section)
    }
}
