//
//  GameViewController.swift
//  Game of Life
//
//  Created by Stephanie Bowles on 6/19/20.
//  Copyright © 2020 Stephanie Bowles. All rights reserved.
//


import UIKit


class GameViewController: UIViewController, GameDelegate {
    func countGeneration() {
        print("hello")
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var dataSource: [Cell]  = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var startStop: Bool = false
    var timer: Timer?
    
    @IBOutlet weak var generationLabel: UILabel!
    
    let pixelSize = 15
    var boardWidth: Int {
        return Int(floor(collectionView.frame.size.width/CGFloat(pixelSize)))
    }
    var boardHeight: Int {
        return Int(floor(collectionView.frame.size.height/CGFloat(pixelSize)))
    }
    
    var game: Game?
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.darkPurpleColor
        NotificationCenter.default.addObserver(self, selector: #selector(refreshGeneration), name: .updateGenerateCount, object: nil)
        //        game.generationCount = 0
        //        guard let game = game else {return NSLog("nil generation count")}
        //        generationLabel.text = String(game.generationCount)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        game = Game(width: boardWidth, height: boardHeight)
        guard let game = game else {return}
        game.addStateObserver { [weak self] state in
            self?.display(state)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(refreshGeneration), name: .updateGenerateCount, object: nil)
        //this adds the moving pieces
    }
    
    
    
    @objc func refreshGeneration(notification: Notification) {
        print("refreshGen called")
        guard let game =  notification.object as? Game else {return NSLog("nil game")}
        
        self.generationLabel.text = String(game.generationCount)
      
    }
    
    
    //    //NOTE: Observer in Game class uses generate initial state and iterate
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
        guard let game = game else {return}
        game.reset()
    }
    
    @IBAction func playPauseButtonToggled(_ sender: Any) {
        //        startStop.toggle()
        //        autoRun(run: startStop)
        guard let game = game else {return}
        game.isPaused.toggle()
    }
    
    
    
    @IBAction func stopButtonToggled(_ sender: Any) {
        //        startStop = false
        //        game = Game(width: boardWidth, height: boardHeight)
        //        collectionView.reloadData()
        //        generationCount = 0
        guard let game = game else {return}
        game.isPaused = true
        game.generateInitialState()
        
    }
    func autoRun(run: Bool){
        
        if startStop {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                guard let game = self.game else {return}
                game.generateInitialState()
                //                Maybe?
                self.collectionView.reloadData()
                //                self.generationCount += 1
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

