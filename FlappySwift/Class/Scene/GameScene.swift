//
//  GameScene.swift
//  FlappySwift
//

import SpriteKit

class GameScene: SKScene , BirdProtocol {
    
    var bird : Bird!
    var world : World!
    
    var time    : CFTimeInterval! = 0
    var time_d  : CFTimeInterval! = 0
    var time_p  : CFTimeInterval! = 0
    
    var rect : CGRect!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        let rect = self.rect
        
        // why scene size (1024.0,768.0) bug ?
        println(self.size)
        
        self.size = rect.size
        
        let pos = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
        
        let world = World(rect:rect)
            world.position = pos
        
        let bird  = Bird(rect:rect)
            bird.position  = pos
            bird.zPosition = 2
        
        self.addChild(world)
        self.addChild(bird)
        
        self.world = world
        self.bird = bird
        
        self.bird.delegate = self;
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.bird.flap()
    }
    
    override func update(currentTime: CFTimeInterval) {

        if time_p > 0 {
            time_d = currentTime - time_p;
        }
        
        time_p = currentTime;
        
        
        if time_d > 0 {
            self.bird.update( time_d )
        }
        
    }
    
    
    func birdDead() {
        println("bird  dead");
    }
}
