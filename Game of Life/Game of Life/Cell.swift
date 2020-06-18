//
//  Cell.swift
//  Game of Life
//
//  Created by Stephanie Bowles on 6/18/20.
//  Copyright © 2020 Stephanie Bowles. All rights reserved.
//

import Foundation

struct Cell {
    var isAlive: Bool = false
    
    static func makeDeadCell() -> Cell {
        return Cell(isAlive: false)
    }
    
    static func makeLiveCell() -> Cell {
        return Cell(isAlive: true)
    }
}
