//
//  Game.swift
//  Game of Life
//
//  Created by Stephanie Bowles on 6/18/20.
//  Copyright © 2020 Stephanie Bowles. All rights reserved.
//

import Foundation

//typealias GameStateObserver = ((GameState) -> Void)?

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
   var timer: Timer?
    var population: Int = 0
    
   weak var delegate: GameDelegate?
   
   init(width: Int, height: Int) {
       self.width = width
       self.height = height
       let cells = Array(repeating: Cell.makeDeadCell(), count: width*height)
       currentState = GameState(cells: cells)
   }
   
   func generateCellLoops(_ generatedCells: @escaping ((GameState) -> Void)) {
     let initialGameState = generateInitialState()
       generatedCells(initialGameState)   //executing the function
      
        iterateCellCycles(generatedCells)  //just passing along the function so that someone else can execute the function
    
   
        //where is the best spot for generation count?
   }
    func iterateCellCycles(_ generatedCells: @escaping ((GameState) -> Void)){
//        if isPaused == true {
//            guard let timer = timer else {return NSLog("no timer")}
//            timer.invalidate()
//
//        }
//        else{
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.33, repeats: true) { _ in
                generatedCells(self.iterate())
                self.generationCount += 1
                NotificationCenter.default.post(name: .updateGenerateCount, object: self)
//            }
           
          
        }
        
    }
    
   func reset() {
       self.population = 0
       self.generationCount = 0 
       generateDeadCells()
        
       invalidateTimer()
   }
   
    func invalidateTimer(){
        timer?.invalidate()
//        isPaused = true
        timer = nil
        
    }
  
   func iterate() -> GameState  {
    var numAlive = 0
    var nextState = currentState
    for i in 0...width - 1 {

            for j in 0...height - 1 {
                let positionInTheArray = j*width + i
                nextState[positionInTheArray] = Cell(isAlive: state(x: i, y: j))
                if nextState[positionInTheArray].isAlive {
                    numAlive += 1
                }
            }
 
        
    }
       self.currentState = nextState
       population = numAlive
       return nextState
   }
   
    func state(x: Int, y: Int) -> Bool {
//        var numAlive = 0
        let numberOfAliveNeighbours = aliveNeighbourCountAt(x: x, y: y)
        let position = x + y*width
        
        let wasPreviouslyAlive = currentState[position].isAlive
        if wasPreviouslyAlive {
            //           numAlive += 1
            //           population = numAlive
            return numberOfAliveNeighbours == 2 || numberOfAliveNeighbours == 3
        }
        else {
            return numberOfAliveNeighbours == 3
        }
//        } if wasPreviouslyAlive{
//            numAlive += 1
//        }
//        population = numAlive
        
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
    
    @discardableResult func generateDeadCells() -> GameState {
        let maxItems = width*height - 1
        let initialStatePoints = Array(0...maxItems)
 
        for point in initialStatePoints{
                currentState[point] = Cell.makeDeadCell()
            }
            return self.currentState
        }
 
 
   private func generateRandom(between range: ClosedRange<Int>, count: Int) -> [Int] {
       return Array(0...count).map { _ in
           Int.random(in: range)
       }
   }
   
}
