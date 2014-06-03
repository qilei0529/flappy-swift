//
//  World.swift
//  FlappySwift
//

import SpriteKit

class World: SKSpriteNode {
    
    init( rect: CGRect ){
        
        println("world init")
        
        let color = UIColor(red: 255, green: 255, blue: 33, alpha: 1)
    
        super.init(texture: nil, color: color, size: rect.size )
        
        let background = SKSpriteNode(imageNamed: "background")
        
            background.position = CGPointMake(0, 60)
        
        self.addChild(background)
        
    }
    
}
