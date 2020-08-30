//
//  GameScene.swift
//  GamificationTest
//
//  Created by Caroline Viana on 29/08/20.
//  Copyright © 2020 Caroline Viana. All rights reserved.
//

import UIKit
import SpriteKit

class GameScene: SKScene {
    
    var snakeSize = 5
    var si: CGPoint!
    var sf: CGPoint!
    var snakeP = [SKSpriteNode(color: .white, size: CGSize(width: 20, height: 20))]
    let pointSize = 20
    var lastMove = "nil"
    var timer = Timer()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = .black
        si = CGPoint(x: self.frame.midX, y: self.frame.midY)
        sf = CGPoint(x: self.frame.midX, y: self.frame.midY)
    }
    
    func touchUp(atPoint pos : CGPoint){
        self.sf = pos
    }
    
    
    func snake(){
        snakeP.popLast()
        let head = SKSpriteNode(color: .green, size: CGSize(width: pointSize, height: pointSize))
        head.position = CGPoint(x: muxtwenty(), y: muxtwenty())
        head.name = "snake"
        addChild(head)
        snakeP.append(head)
        
        
            let snakePart = SKSpriteNode(color: .green, size: CGSize(width: pointSize, height: pointSize))
            snakePart.position = CGPoint(x: head.position.x + CGFloat(pointSize), y: head.position.y)
            addChild(snakePart)
        snakeP.append(snakePart)
        let snakeParte = SKSpriteNode(color: .green, size: CGSize(width: pointSize, height: pointSize))
            snakeParte.position = CGPoint(x: snakePart.position.x + CGFloat(pointSize), y: snakePart.position.y)
            addChild(snakeParte)
        snakeP.append(snakeParte)
        
        food()
    }
    
    func food(){
        let food = SKSpriteNode(color: .red, size: CGSize(width: pointSize, height: pointSize))
        food.position = CGPoint(x: CGFloat(integerLiteral: muxtwenty()), y: CGFloat(integerLiteral: muxtwenty()))
        
        food.name = "food"
        addChild(food)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        self.si = touch.location(in: self)
        
        let snake = childNode(withName: "snake")
        
        
        if !timer.isValid{
            timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { timer in
                switch self.lastMove {
                    case "L":
                        self.moveParts()
                        snake?.position = CGPoint(x: snake!.position.x - CGFloat(self.pointSize), y: snake!.position.y)
//                        snake?.run(SKAction.move(to: CGPoint(x: snake!.position.x - CGFloat(pointSize), y: snake!.position.y), duration: 0.2))
                        break
                    case "R":
                        self.moveParts()
                        snake?.position = CGPoint(x: snake!.position.x + CGFloat(self.pointSize), y: snake!.position.y)
//                        snake?.run(SKAction.move(to: CGPoint(x: snake!.position.x + CGFloat(pointSize), y: snake!.position.y), duration: 0.2))
                        break
                    case "U":
                        self.moveParts()
                        snake?.position = CGPoint(x: snake!.position.x, y: snake!.position.y + CGFloat(self.pointSize))
//                        snake?.run(SKAction.move(to: CGPoint(x: snake!.position.x, y: snake!.position.y + CGFloat(pointSize)), duration: 0.2))
                        break
                    case "D":
                        self.moveParts()
                        snake?.position = CGPoint(x: snake!.position.x, y: snake!.position.y - CGFloat(self.pointSize))
//                        snake?.run(SKAction.move(to: CGPoint(x: snake!.position.x, y: snake!.position.y - CGFloat(pointSize)), duration: 0.2))
                        break
                    default:
                        break
             }
                        
            })
            timer.fire()
        }
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        move()
        self.moveParts()
    }
    
    func muxtwenty() -> Int{
        var a = 0
        while true {
            a = Int.random(in: pointSize...Int(self.frame.maxX - CGFloat(pointSize)))
            if a % 20 == 0 {break}
        }
        return a
    }
    
    func move(){
        let travel = CGPoint(x: self.sf.x - self.si.x, y: self.sf.y - self.si.y)
        let snake = childNode(withName: "snake")
//        var this: CGFloat!
        snake?.removeAllActions()
        if abs(travel.x) > abs(travel.y) {
            if travel.x > 0 {
//                snake!.run(SKAction.move(to: CGPoint(x: snake!.position.x + CGFloat(pointSize), y: snake!.position.y), duration: 0.2))
                snake?.position = CGPoint(x: snake!.position.x + CGFloat(pointSize), y: snake!.position.y)
                lastMove = "R"
            }
            else if travel.x < 0 {
//                snake!.run(SKAction.move(to: CGPoint(x: snake!.position.x - CGFloat(pointSize), y: snake!.position.y), duration: 0.2))
                snake?.position = CGPoint(x: snake!.position.x - CGFloat(pointSize), y: snake!.position.y)
                lastMove = "L"
            }
        }
        else if abs(travel.x) < abs(travel.y) {
            if travel.y > 0 {
//                snake!.run(SKAction.move(to: CGPoint(x: snake!.position.x, y: snake!.position.y + CGFloat(pointSize)), duration: 0.2))
                snake?.position = CGPoint(x: snake!.position.x, y: snake!.position.y + CGFloat(pointSize))
                lastMove = "U"
            }
            else if travel.y < 0 {
//                snake!.run(SKAction.move(to: CGPoint(x: snake!.position.x, y: snake!.position.y - CGFloat(pointSize)), duration: 0.2))
                snake?.position = CGPoint(x: snake!.position.x, y: snake!.position.y - CGFloat(pointSize))
                lastMove = "D"
            }
        }
        
        self.si = snake?.position
        
        
    }
    
    func moveParts(){
        var index = snakeP.endIndex
        index = snakeP.index(before: index)
        while true {
            if index == snakeP.startIndex {break}
            snakeP[index].position = snakeP[snakeP.index(before: index)].position
            index = snakeP.index(before: index)
        }
    }
    
    
    
    
}
