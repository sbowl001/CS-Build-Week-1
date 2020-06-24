//
//  Game.swift
//  Game of Life
//
//  Created by Stephanie Bowles on 6/18/20.
//  Copyright © 2020 Stephanie Bowles. All rights reserved.
//

import Foundation

typealias GameStateObserver = ((GameState) -> Void)?

protocol GameDelegate: class {
//    func countGeneration( ) {
//        generationCount += 1
   
}

class Game {
   let width: Int
   let height: Int
   var currentState: GameState
   var isPaused: Bool = false
   var generationCount: Int = 0
    
   weak var delegate: GameDelegate?
   
   init(width: Int, height: Int) {
       self.width = width
       self.height = height
       let cells = Array(repeating: Cell.makeDeadCell(), count: width*height)
       currentState = GameState(cells: cells)
   }
   
   func addStateObserver(_ observer: GameStateObserver) {
       observer?(generateInitialState())
       Timer.scheduledTimer(withTimeInterval: 0.33, repeats: true) { _ in
           observer?(self.iterate())
        self.generationCount += 1
        NotificationCenter.default.post(name: .updateGenerateCount, object: self)
       }
       
   }
   
   func reset() {
       
       self.generateInitialState()
       NotificationCenter.default.post(name: .updateGenerateCount, object: self)
   }
   
    
  
   func iterate() -> GameState  {
    
   
       var nextState = currentState
       for i in 0...width - 1 {
            if isPaused == true {
               break
           }
           for j in 0...height - 1 {
               let positionInTheArray = j*width + i
               nextState[positionInTheArray] = Cell(isAlive: state(x: i, y: j))
           }
       }
       self.currentState = nextState
      
      
       
//       delegate?.countGeneration()
        
       return nextState

   }
   
   func state(x: Int, y: Int) -> Bool {
       let numberOfAliveNeighbours = aliveNeighbourCountAt(x: x, y: y)
       let position = x + y*width
       
       let wasPreviouslyAlive = currentState[position].isAlive
       if wasPreviouslyAlive {
           return numberOfAliveNeighbours == 2 || numberOfAliveNeighbours == 3
       } else {
           return numberOfAliveNeighbours == 3
       }
   }
   
   func aliveNeighbourCountAt(x: Int, y: Int) -> Int {
       var numberOfAliveNeighbours = 0
       for i in x-1...x+1 {
           for j in y-1...y+1 {
               if (i == x && y == j) || (i >= width) || (i < 0) || (j < 0 ) {continue}
               
               let index = j*width + i
               
               guard index >= 0 && index < width*height else {continue}
               if currentState[index].isAlive {
                   numberOfAliveNeighbours += 1
               }
           }
       }
       return numberOfAliveNeighbours
   }
   
   func setInitialState(_ state: GameState) {
       currentState = state
   }
   
   /*
    We should feed the game an initial state to start with
    we can do it with random generated numbers i.e
    */
   @discardableResult
   func generateInitialState() -> GameState {
       let maxItems = width*height - 1
       let initialStatePoints = self.generateRandom(between: 0...maxItems, count: maxItems/8)

       for point in initialStatePoints{
           currentState[point] = Cell.makeLiveCell()
       }
       return self.currentState
   }
   
   private func generateRandom(between range: ClosedRange<Int>, count: Int) -> [Int] {
       return Array(0...count).map { _ in
           Int.random(in: range)
       }
   }
   
}
