//
//  GameViewController.swift
//  Game of Life
//
//  Created by Stephanie Bowles on 6/19/20.
//  Copyright © 2020 Stephanie Bowles. All rights reserved.
//


import UIKit


class GameViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var dataSource: [Cell]  = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    var generationCount: Int = 0
    var startStop: Bool = false
    var timer: Timer?
    
    
    let pixelSize = 15
    var boardWidth: Int {
        return Int(floor(collectionView.frame.size.width/CGFloat(pixelSize)))
    }
    var boardHeight: Int {
        return Int(floor(collectionView.frame.size.height/CGFloat(pixelSize)))
    }

    var game: Game!

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.darkPurpleColor
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        game = Game(width: boardWidth, height: boardHeight)
        game.addStateObserver { [weak self] state in
             self?.display(state)
        }
        //this adds the moving pieces
    }
   
    
    //NOTE: Observer in Game class uses generate initial state and iterate
//    func addStateObserver(_ observer: GameStateObserver) {
//    observer?(generateInitialState())
//    Timer.scheduledTimer(withTimeInterval: 0.33, repeats: true) { _ in
//        observer?(self.iterate())
//    }
//}
//
    func display(_ state: GameState) {
        self.dataSource = state.cells
    }
    
    @IBAction func resetAction(_ sender: UIButton) {
        game.reset()
    }
    
    @IBAction func playPauseButtonToggled(_ sender: Any) {
        startStop.toggle()
        autoRun(run: startStop)
    }
    
    
    
    @IBAction func stopButtonToggled(_ sender: Any) {
        startStop = false
        collectionView.reloadData()
        generationCount = 0
    }
    func autoRun(run: Bool){
        if startStop {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.game.generateInitialState()
//                Maybe?
                self.collectionView.reloadData()
                self.generationCount += 1
                self.autoRun(run: run)
            }
        }
    }
}

extension GameViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(SquareCollectionViewCell.self)", for: indexPath) as! SquareCollectionViewCell
        cell.configureWithState(dataSource[indexPath.item].isAlive)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: pixelSize, height: pixelSize)
    }

}

