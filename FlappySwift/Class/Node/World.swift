//
//  World.swift
//  FlappySwift
//

import SpriteKit

class World: SKSpriteNode {
    
    let rect : CGRect!
    
    var box_left : CGFloat?
    
    init( rect: CGRect ){
        println("world init")
        
//        let color = UIColor(red: 112/255, green: 197/255, blue: 206/255, alpha: 1)
        let color = UIColor(red: 222/255, green: 216/255, blue: 149/255, alpha: 1)
    
        super.init(texture: nil, color: color, size: rect.size )
        
        let background = SKSpriteNode(imageNamed: "background")
        
            background.position = CGPointMake(0, 60)
        
        self.addChild(background)
        
        self.rect = rect
        self.init_root()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func init_root () {
        
        let root = SKNode()
        
        let texture = SKTexture(imageNamed: "root")
        
        println(texture)
        
        let d = texture.size()
        
        box_left = -self.rect.size.width / 2 - 20
        
        let h = -d.height / 2
        
        for i in 0...30 {
            let box = SKSpriteNode(texture: texture)
            
            box_left = box_left! + d.width
            let pos = CGPointMake( box_left! , h)
            
            println(i , pos)
            box.position = pos
            root.addChild(box)
        }
        
        println(size)
        root.zPosition = 2
        self.addChild(root)
        
        func call() -> Void {
            println("call~")
            root.position = CGPointMake(0, -164)
        }
        
        call()
        
        let move  = SKAction.moveBy(CGVectorMake(-200 , 0), duration: 4)
        let reset = SKAction.runBlock(call)
        let seq   = SKAction.sequence([move, reset])
        let repeat = SKAction.repeatActionForever(seq)

        root.runAction(repeat, withKey: "root")
        
    }
    
    
}
