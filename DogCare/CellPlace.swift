//
//  CellPlace.swift
//  DogCare
//
//  Created by user167535 on 6/17/20.
//  Copyright © 2020 user167535. All rights reserved.
//

import UIKit
import MapViewPlus

class CellPlace: CalloutViewModel {
    var title: String
    var image: UIImage

    init(title: String, image: UIImage) {
      self.title = title
      self.image = image
    }
}
