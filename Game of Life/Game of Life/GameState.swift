//
//  GameState.swift
//  Game of Life
//
//  Created by Stephanie Bowles on 6/18/20.
//  Copyright © 2020 Stephanie Bowles. All rights reserved.
//

import Foundation

struct GameState {
    var cells: [Cell] = []
    
    subscript(index: Int) -> Cell {
        get {
            return cells[index]
//            can access cell directly instead of gameState.cells[i] . can now say gameState[i]
        }
        
    }
    
   
}
