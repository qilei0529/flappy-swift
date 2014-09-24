//
//  Bird.swift
//  FlappySwift
//

import SpriteKit

protocol BirdProtocol {
    func birdDead()
}

class Bird: SKNode {
    
    var bird : SKSpriteNode!
    var start_flag : Bool?
    var time_d : CFTimeInterval!
    let rect : CGRect!
    var delegate : BirdProtocol?
    
    init( rect: CGRect ){
        super.init()
        
        println("bird init")
        
        self.rect = rect
        
        let img = SKTexture(imageNamed: "bird-1")
        let bird = SKSpriteNode(texture: img)
        
        self.addChild(bird)
        self.bird = bird
        
        bird.physicsBody = SKPhysicsBody( rectangleOfSize:bird.size )
        bird.physicsBody?.dynamic = false
        
        
        start_flag = false
        self.reset()
        self.move()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move(){
        let img_frames = [
            SKTexture(imageNamed: "bird-1"),
            SKTexture(imageNamed: "bird-2"),
            SKTexture(imageNamed: "bird-3"),
        ]
        
        let action = SKAction.animateWithTextures(img_frames, timePerFrame: 0.1)
        let repeat = SKAction.repeatActionForever(action)
        
        bird.runAction(repeat, withKey: "move")

    }
    
    func start(){
        self.move()
        bird.physicsBody?.dynamic = true
    }
    
    func flap() {
        println("tap")
        if self.start_flag == false {
            println("start")
            start()
            start_flag = true
        }
        
        bird.physicsBody?.velocity = CGVectorMake(0, 0)
//        bird.physicsBody.linearDamping = 0.5 // set damping
        bird.physicsBody?.applyImpulse(CGVectorMake(0, 40))
        
    }
    
    func update( time: CFTimeInterval ) {
        if start_flag == true {
            check_bird()
        }
    }
    
    func reset() {
        bird.position = CGPointMake(0, 50)
        bird.zRotation = 0
    }
    
    func dead() {
        self.start_flag = false
        bird.physicsBody?.velocity = CGVectorMake(0, 0)
        bird.physicsBody?.dynamic = false
        bird.removeActionForKey("move")
        
        bird.zRotation = -1.57
        
        println("stop")
        
        delegate?.birdDead()
    }
    
    func check_bird() {
        
        var dy = bird.physicsBody?.velocity.dy
        
        if dy < -200.0 {
            if dy < -600 {
                dy = -600
            }
            bird.zRotation = 1.52 * (dy! + 200) * 0.0025
            
        }else if dy > -100 {
            if dy > 100{
                dy = 100;
            }
            bird.zRotation = 0.6 * (dy! + 100) * 0.005
            
        }else {
            bird.zRotation = 0.0
        }
        
        let btm : CGFloat = -150
        let top = self.rect.height / 2
        let p = bird.position.y
        
        if p < btm {
            bird.position = CGPointMake(0, btm)
            self.dead()
        }else if p > top {
            bird.position = CGPointMake(0, top)
        }
        
    }
}
