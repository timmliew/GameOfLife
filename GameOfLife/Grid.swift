//
//  Grid.swift
//  GameOfLife
//
//  Created by Timothy Liew on 6/24/16.
//  Copyright © 2016 Tim Liew. All rights reserved.
//

import SpriteKit

class Grid: SKSpriteNode {
    /* Grid array dimensions */
    let rows = 8
    let columns = 10
    var gridArray = [[Creature]]()
    var generation = 0
    var population = 0
    
    /* Individual cell dimension, calculated in setup*/
    var cellWidth = 0
    var cellHeight = 0
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
    
         /* There will only be one touch as multi touch is not enabled by default */
        for touch in touches{
            /* Grab position of touch relative to the grid */
            let location = touch.locationInNode(self)
        
        let gridX = Int(location.x) / cellWidth
        let gridY = Int (location.y) / cellHeight
            
        let creature = gridArray[gridX][gridY]
        creature.isAlive = !creature.isAlive
        
        }
    }
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        /* Enable own touch implementation for this node */
        userInteractionEnabled = true
        
        /* Calculate individual cell dimensions */
        cellWidth = Int(size.width) / columns
        cellHeight = Int(size.height) / rows
        
        populateGrid()
    }

    func populateGrid(){
        /* Populate the grid with creatures */
        
        /* Loop through columns */
        for col in 0..<columns{
            
            /* Initialize empty column */
            gridArray.append([])
            
            /* Loop through rows */
            for row in 0..<rows{
                /* Add creature at position */
                addCreatureAtGrid(col, y: row)
            }
        }
    }

    func addCreatureAtGrid(x: Int, y: Int){
        /* add a creature at new grid position */
        
        /*Create new creature object*/
        let creature = Creature()
        
        /* Calculate position on screen */
        let gridPosition = CGPoint(x: x*cellWidth, y: y*cellWidth)
        creature.position = gridPosition
        
        /* Show creature on the grid */
        creature.isAlive = false
        
        /* Add creature to grid node */
        addChild(creature)
        
        /* Add creature to grid array */
        gridArray[x].append(creature)
    }
    
    func countNeighbors(){
        /* Loop through columns */
        for gridX in 0..<columns {
            
            /* Loop through rows */
            for gridY in 0..<rows {
                
                /* Grab creature at grid position */
                let currentCreature = gridArray[gridX][gridY]
                
                /* Reset neighbor count */
                currentCreature.neighborCount = 0
                
                /* Loop through all adjacent creatures to current creature */
                for innerGridX in (gridX - 1)...(gridX + 1) {
                    
                    /* Ensure inner grid column is inside array */
                    if innerGridX<0 || innerGridX >= columns { continue }
                    
                    for innerGridY in (gridY - 1)...(gridY + 1) {
                        
                        /* Ensure inner grid row is inside array */
                        if innerGridY<0 || innerGridY >= rows { continue }
                        
                        /* Creature can't count itself as a neighbor */
                        if innerGridX == gridX && innerGridY == gridY { continue }
                        
                        /* Grab adjacent creature reference */
                        let adjacentCreature:Creature = gridArray[innerGridX][innerGridY]
                        
                        /* Only interested in living creatures */
                        if adjacentCreature.isAlive {
                            currentCreature.neighborCount += 1
                        }  
                    }
                }    
            }
        }
    }
    
    func updateCreatures() {
        /* Process array and update creature status */
        
        /* Reset population counter */
        population = 0
        
        /* Loop through columns */
        for gridX in 0..<columns {
            
            /* Loop through rows */
            for gridY in 0..<rows {
                
                /* Grab creature at grid position */
                let currentCreature = gridArray[gridX][gridY]
                
                /* Check against game of life rules */
                switch currentCreature.neighborCount {
                case 3:
                    currentCreature.isAlive = true
                    break;
                case 0...1, 4...8:
                    currentCreature.isAlive = false
                    break;
                default:
                    break;
                }
                
                /* Refresh population count */
                if currentCreature.isAlive { population += 1 }
            }
        }
    }
    
    func evolve(){
        countNeighbors()
        
        updateCreatures()
        
        generation += 1
    }
    
}