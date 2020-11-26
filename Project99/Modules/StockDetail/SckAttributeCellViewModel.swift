//
//  SckAttributeCellViewModel.swift
//  Project99
//
//  Created by Ricardo González Pacheco on 25/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

class SckAttributeCellViewModel {
    let position: Int
    let value: String
    init(position: Int, value: String) {
        self.position = position
        self.value = value
    }
}
