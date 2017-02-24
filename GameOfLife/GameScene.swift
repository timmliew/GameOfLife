//
//  GameScene.swift
//  GameOfLife
//
//  Created by Timothy Liew on 6/24/16.
//  Copyright (c) 2016 Tim Liew. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var playButton: MSButtonNode!
    var pauseButton: MSButtonNode!
    var stepButton: MSButtonNode!
    var populationNum: SKLabelNode!
    var generationNum: SKLabelNode!
    var gridNode: Grid!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        playButton = childNodeWithName("playButton") as! MSButtonNode
        pauseButton = childNodeWithName("pauseButton") as! MSButtonNode
        stepButton = childNodeWithName("stepButton") as! MSButtonNode
        populationNum = childNodeWithName("populationNum") as! SKLabelNode
        generationNum = childNodeWithName("generationNum") as! SKLabelNode
        gridNode = childNodeWithName("gridNode") as! Grid
        
        stepButton.selectedHandler = {
            self.stepSimulation()
        }
        
        /* Create an SKAction based timer, 0.5 second delay */
        let delay = SKAction.waitForDuration(0.5)
        
        /* Call the stepSimulation() method to advance the simulation */
        let callMethod = SKAction.performSelector(#selector(GameScene.stepSimulation), onTarget: self)
        
        /* Create the delay,step cycle */
        let sequence = SKAction.sequence([delay, callMethod])
        
        /* Create an infinite simulation loop */
        let simulation = SKAction.repeatActionForever(sequence)
        
        /* Run simulation action */
        self.runAction(simulation)
        
        /* Default simulation to pause state */
        self.paused = true
        
        /* Setup play button selected handler */
        playButton.selectedHandler = {
            self.paused = false
        }
        
        /* Setup pause button selected handler */
        pauseButton.selectedHandler = {
            self.paused = true
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func stepSimulation(){
        
        gridNode.evolve()
        
        populationNum.text = String(gridNode.population)
        generationNum.text = String(gridNode.generation)
    }
}