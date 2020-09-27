//
//  GameScene.swift
//  GamificationTest
//
//  Created by Caroline Viana on 29/08/20.
//  Copyright © 2020 Caroline Viana. All rights reserved.
//

import UIKit
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let sprites = [SKTexture(imageNamed: "bee0"), SKTexture(imageNamed: "bee1")]
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //MARK: init
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = .white
        
        
        
    }
    
    func animateBee(){
        let bee = SKSpriteNode(imageNamed: "bee0")
        let posX = CGFloat.random(in: self.frame.minX...self.frame.maxX)
        bee.position = CGPoint(x: posX, y: -30)
        bee.size = CGSize(width: bee.size.width / 4, height: bee.size.height / 4)
        addChild(bee)
        
        let animation = SKAction.animate(with: sprites, timePerFrame: 0.1)
        let animate = SKAction.repeatForever(animation)
        bee.run(animate)
        bee.run(SKAction.move(to: CGPoint(x: bee.position.x, y: frame.maxY + 30), duration: 5))
        
        if bee.position.y >= frame.maxY + 30{bee.removeFromParent()}
        
    }
}
