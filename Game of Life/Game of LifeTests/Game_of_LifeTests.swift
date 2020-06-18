//
//  Game_of_LifeTests.swift
//  Game of LifeTests
//
//  Created by Stephanie Bowles on 6/18/20.
//  Copyright © 2020 Stephanie Bowles. All rights reserved.
//

import XCTest

class Game_of_LifeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
      func test_survival() {
          let twoAliveNeighboursGameState = GameState(cells:
              
                                          [Cell.makeDeadCell(),
                                           Cell.makeDeadCell(),
                                           Cell.makeDeadCell(),
                                           Cell.makeLiveCell(),
                                           Cell.makeLiveCell(),
                                           Cell.makeLiveCell(),
                                           Cell.makeDeadCell(),
                                           Cell.makeDeadCell(),
                                           Cell.makeDeadCell()])
          game.setInitialState(twoAliveNeighboursGameState)
          XCTAssertTrue(game.state(x: 1, y: 1))

          let threeAliveNeighboursGameState = GameState(cells:
              
                                              [Cell.makeDeadCell(),
                                               Cell.makeLiveCell(),
                                               Cell.makeDeadCell(),
                                               Cell.makeDeadCell(),
                                               Cell.makeLiveCell(),
                                               Cell.makeLiveCell(),
                                               Cell.makeDeadCell(),
                                               Cell.makeLiveCell(),
                                               Cell.makeDeadCell()])
          game.setInitialState(threeAliveNeighboursGameState)
          XCTAssertTrue(game.state(x: 1, y: 1))
      }

      func test_birth(){
          //2. A dead square with exactly three live neighbors becomes a live cell (birth)
          
          let deadCellState = GameState(cells:[Cell.makeLiveCell(),
                                               Cell.makeDeadCell(),
                                               Cell.makeDeadCell(),
                                               Cell.makeLiveCell(),
                                               Cell.makeLiveCell(),
                                               Cell.makeDeadCell(),
                                               Cell.makeDeadCell(),
                                               Cell.makeDeadCell(),
                                               Cell.makeDeadCell()
                                              ])
          game.setInitialState(deadCellState)
          XCTAssertTrue(game.state(x: 1, y: 0))
      }
      
      func test_death(){
          let lonelyState = GameState(cells: [Cell.makeDeadCell(),                                         Cell.makeDeadCell(),                                         Cell.makeDeadCell(),
                                              Cell.makeDeadCell(),
                                              Cell.makeLiveCell(),
                                              Cell.makeDeadCell(),
                                              Cell.makeDeadCell(),
                                              Cell.makeDeadCell(),
                                              Cell.makeDeadCell()])
          game.setInitialState(lonelyState)
          XCTAssertEqual(false, game.state(x: 1, y: 1))
          
          let overcrowdingState = GameState(cells: [Cell.makeLiveCell(),                                         Cell.makeLiveCell(),                                         Cell.makeLiveCell(),
                                                    Cell.makeLiveCell(),    Cell.makeLiveCell(),    Cell.makeLiveCell(),
                                                    Cell.makeLiveCell(),    Cell.makeLiveCell(),    Cell.makeLiveCell()])
          game.setInitialState(overcrowdingState)
          XCTAssertEqual(false, game.state(x: 1, y: 1))
      }
      
}
