//
//  Bird.swift
//  FlappySwift
//

import SpriteKit

class Bird: SKNode {
    
    var bird : SKSpriteNode!
    
    var start_flag : Bool?
    
    var time_d : CFTimeInterval!
    
    let rect : CGRect!
    
    init( rect: CGRect ){
        super.init()
        
        println("bird init")
        
        self.rect = rect
        
        let img = SKTexture(imageNamed: "bird-1")
        let bird = SKSpriteNode(texture: img)
        
        self.addChild(bird)
        self.bird = bird
        
        bird.physicsBody = SKPhysicsBody( rectangleOfSize:bird.size )
        bird.physicsBody.dynamic = false
        
        start_flag = false
        self.reset()
        self.move()
    }
    
    func move(){
        let img_frames = [
            SKTexture(imageNamed: "bird-1"),
            SKTexture(imageNamed: "bird-2"),
            SKTexture(imageNamed: "bird-3"),
        ]
        let action = SKAction.repeatActionForever(SKAction.animateWithTextures(img_frames, timePerFrame: 0.1))
        
        bird.runAction(action, withKey: "move")

    }
    
    func start(){
        
        bird.physicsBody.dynamic = true
    }
    
    func flap() {
        println("tap")
        if self.start_flag == false {
            println("start")
            start()
            start_flag = true
        }
        
        bird.physicsBody.velocity = CGVectorMake(0, 0)
        bird.physicsBody.applyImpulse(CGVectorMake(0, 40))
        
    }
    
    func update( time: CFTimeInterval ) {
        if start_flag == true {
            println("update bird ")
            check_bird()
        }
    }
    
    func reset() {
        bird.position = CGPointMake(0, 50)
        bird.zRotation = 0
    }
    
    func dead() {
        self.start_flag = false
        bird.physicsBody.velocity = CGVectorMake(0, 0)
        bird.physicsBody.dynamic = false
        bird.removeActionForKey("move")
        
        bird.zRotation = -1.57
        
        println("stop")
    }
    
    func check_bird() {
        
        var dy = bird.physicsBody.velocity.dy
        
        if dy > 30.0 {
            bird.zRotation = 0.6
        } else if dy < -100.0 {
            if dy < -600 {
                dy = -600
            }
            
            bird.zRotation = 1.52 * (dy + 100) * 0.002
        } else {
            bird.zRotation = 0.0
        }
        
        let h = -self.rect.height / 2 + 140
        
        
        let p = bird.position.y
        
        println(p)
        
        if p < h {
            bird.position = CGPointMake(0, h)
            self.dead()
        }
        
    }
}
