//
//  Game.swift
//  Game of Life
//
//  Created by Stephanie Bowles on 6/18/20.
//  Copyright © 2020 Stephanie Bowles. All rights reserved.
//

import Foundation


class Game {
    let width:  Int
    let height: Int
    var currentState: GameState
    
    
func state(x: Int, y: Int) -> Bool {
    var numberOfAliveNeighbors = 0
    let previousPosition = x + y * width
    
    for i in x - 1 ... x+1 {
        for j in y-1 ... y+1 {
            let positionInTheArray = j * width + i
            guard positionInTheArray >= 0 && positionInTheArray < width*height && previousPosition != positionInTheArray else {continue}
            if currentState[positionInTheArray].isAlive {
                numberOfAliveNeighbors += 1
            }
        }
    }
    
    let wasPreviouslyAlive = currentState[previousPosition].isAlive
    
    if wasPreviouslyAlive {
        return numberOfAliveNeighbors == 2 || numberOfAliveNeighbors == 3
    }
    
    return false 
}


func iterate() -> GameState {
       var nextState = currentState
       for i in 0...width - 1 {
           for j in 0...height - 1 {
               let positionInTheArray = j * width + 1
               nextState[positionInTheArray] = Cell(isAlive: state(x: i, y: j))
           }
       }
       
       self.currentState = nextState
       return nextState
   }
}
