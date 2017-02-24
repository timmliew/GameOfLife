//
//  Creature.swift
//  GameOfLife
//
//  Created by Timothy Liew on 6/24/16.
//  Copyright © 2016 Tim Liew. All rights reserved.
//

import SpriteKit

class Creature: SKSpriteNode{
    
    /* Character side */
    var isAlive: Bool = false{
        didSet {
            /*Visibility*/
            hidden = !isAlive
        }
    }
    
    /* Living neighbor counter */
    var neighborCount = 0
    
    init(){
        /*Initialize with bubble asset*/
        let texture = SKTexture(imageNamed: "bubble")
        super.init(texture : texture, color: UIColor.clearColor(), size: texture.size())
        
        zPosition = 1
        
        anchorPoint = CGPoint(x: 0, y: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
