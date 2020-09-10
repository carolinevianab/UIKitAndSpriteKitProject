//
//  GameScene.swift
//  GamificationTest
//
//  Created by Caroline Viana on 29/08/20.
//  Copyright © 2020 Caroline Viana. All rights reserved.
//

import UIKit
import SpriteKit

enum CollisionType: UInt32{
    case walls = 1
    case snake = 2
    case food = 4
    case head = 8
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var snakeSize = 5
    var si: CGPoint!
    var sf: CGPoint!
    var snakeP = [SKSpriteNode(color: .white, size: CGSize(width: 20, height: 20))]
    let pointSize = 20
    var lastMove = "nil"
    var timer = Timer()
    var score = 0
    var bPos: CGPoint!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //MARK: init
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = .black
        si = CGPoint(x: self.frame.midX, y: self.frame.midY)
        sf = CGPoint(x: self.frame.midX, y: self.frame.midY)
        physicsWorld.contactDelegate = self
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)))
        
        
    }
    
    //MARK: touchUp
    func touchUp(atPoint pos : CGPoint){
        self.sf = pos
    }
    
    //MARK: Snake
    func snake(){
        si = CGPoint(x: self.frame.midX, y: self.frame.midY)
        sf = CGPoint(x: self.frame.midX, y: self.frame.midY)
        lastMove = "nil"
        score = 0
        snakeP.removeAll()
        
        let head = SKSpriteNode(color: .green, size: CGSize(width: pointSize, height: pointSize))
        head.position = CGPoint(x: muxtwenty(), y: muxtwenty())
        head.name = "snake"
        addChild(head)
        head.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: pointSize, height: pointSize))
        head.physicsBody?.affectedByGravity = false
        head.physicsBody?.categoryBitMask = CollisionType.head.rawValue
        head.physicsBody?.collisionBitMask = CollisionType.food.rawValue | CollisionType.snake.rawValue | CollisionType.walls.rawValue
        head.physicsBody?.contactTestBitMask = CollisionType.food.rawValue | CollisionType.snake.rawValue | CollisionType.walls.rawValue
        head.physicsBody?.allowsRotation = false
        snakeP.append(head)
        
        newPart()
        newPart()
        food()
        scoreAppear()
    }
    
    //MARK: scoreAppear
    func scoreAppear(){
        let labell = SKLabelNode(text: "Score: \(score)")
        labell.position = CGPoint(x: self.frame.minX, y: self.frame.maxY)
        labell.verticalAlignmentMode = .top
        labell.horizontalAlignmentMode = .left
        labell.name = "score"
        labell.fontColor = .white
        self.addChild(labell)
    }
    
    //MARK: food
    func food(){
        let food = SKSpriteNode(color: .red, size: CGSize(width: pointSize, height: pointSize))
        
        while true {
            food.position = CGPoint(x: CGFloat(integerLiteral: muxtwenty()), y: CGFloat(integerLiteral: muxtwenty()))
            if nodes(at: food.position) == [] {
                break
            }
        }
        food.name = "food"
        food.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 5, height: 5))
        food.physicsBody?.affectedByGravity = false
        food.physicsBody?.allowsRotation = false
        addChild(food)
    }
    
    //MARK: touchesBegan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        self.si = touch.location(in: self)
        
        let snakeHead = childNode(withName: "snake")
        guard snakeHead != nil else {return}
        
        if !timer.isValid{
            timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { timer in
                switch self.lastMove {
                    case "L":
                        self.bPos = snakeHead?.position
                        self.moveParts()
                        snakeHead?.position = CGPoint(x: snakeHead!.position.x - CGFloat(self.pointSize), y: snakeHead!.position.y)
                        self.moveLast()
                        break
                    case "R":
                        self.bPos = snakeHead?.position
                        self.moveParts()
                        snakeHead?.position = CGPoint(x: snakeHead!.position.x + CGFloat(self.pointSize), y: snakeHead!.position.y)
                        self.moveLast()
                        break
                    case "U":
                        self.bPos = snakeHead?.position
                        self.moveParts()
                        snakeHead?.position = CGPoint(x: snakeHead!.position.x, y: snakeHead!.position.y + CGFloat(self.pointSize))
                        self.moveLast()
                        break
                    case "D":
                        self.bPos = snakeHead?.position
                        self.moveParts()
                        snakeHead?.position = CGPoint(x: snakeHead!.position.x, y: snakeHead!.position.y - CGFloat(self.pointSize))
                        self.moveLast()
                        break
                    default:
                        break
             }
                        
            })
            timer.fire()
        }
    }
    
    //MARK: update
    override func update(_ currentTime: TimeInterval) {
        let lblScore = childNode(withName: "score")
        if lblScore != nil {
            let a = lblScore as! SKLabelNode
            a.text = "Score: \(score)"
        }
    }
    
    //MARK: touchesEnded
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        move()
        if childNode(withName: "Over") != nil {
            if (childNode(withName: "Over")?.contains(touches.first!.location(in: self)))! {
                self.removeAllChildren()
                snake()
                
            }
        }
        else{
            self.moveParts()
        }
    }
    
    //MARK: muxTwenty
    func muxtwenty() -> Int{
        var a = 0
        while true {
            a = Int.random(in: pointSize...Int(self.frame.maxX - CGFloat(pointSize) * 3))
            if a % 20 == 0 {break}
        }
        return a
    }
    
    //MARK: move
    func move(){
        let travel = CGPoint(x: self.sf.x - self.si.x, y: self.sf.y - self.si.y)
        let snake = childNode(withName: "snake")
        snake?.removeAllActions()
        
        if abs(travel.x) > abs(travel.y) {
            if travel.x > 0 {
                lastMove = "R"
            }
            else if travel.x < 0 {
                lastMove = "L"
            }
        }
        else if abs(travel.x) < abs(travel.y) {
            if travel.y > 0 {
                lastMove = "U"
            }
            else if travel.y < 0 {
                lastMove = "D"
            }
        }
        
        self.si = snake?.position
        
        
    }
    
    //MARK: moveParts
    func moveParts(){
        var index = snakeP.endIndex
        while true {
            index = snakeP.index(before: index)
            if snakeP.index(before: index) == snakeP.startIndex {break}
            snakeP[index].position = snakeP[snakeP.index(before: index)].position
            
        }
    }
    
    //MARK: moveLast
    func moveLast(){
        var index = snakeP.startIndex
        index = snakeP.index(after: index)
        snakeP[index].position = bPos
    }
    
    //MARK: newPart
    func newPart(){
        let snakePart = SKSpriteNode(color: .systemGreen, size: CGSize(width: pointSize, height: pointSize))
        var index = snakeP.endIndex
        index = snakeP.index(before: index)
        snakePart.position = CGPoint(x: snakeP[index].position.x + CGFloat(pointSize), y: snakeP[index].position.y)
        snakePart.name = "SnakePart"
        addChild(snakePart)
        snakePart.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 5, height: 5))
        snakePart.physicsBody?.affectedByGravity = false
        snakePart.physicsBody?.allowsRotation = false
        snakePart.physicsBody?.categoryBitMask = CollisionType.snake.rawValue
        snakePart.physicsBody?.collisionBitMask = CollisionType.head.rawValue | CollisionType.walls.rawValue
        snakePart.physicsBody?.contactTestBitMask = CollisionType.head.rawValue | CollisionType.walls.rawValue
        snakeP.append(snakePart)
        
    }
    
    //MARK: didBegin
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        
        let sortedNodes = [nodeA, nodeB].sorted {$0.name ?? "" <  $1.name ?? ""}
        // Ordem alfabética:
        //Scene (literally)
        //food
        //SnakePart
        //snake
        
        let firstNode = sortedNodes[0]
        let secondNode = sortedNodes[1]
        
        if firstNode.children != []{
            self.removeAllChildren()
            gameOver()
        }
        
        if firstNode.name == "SnakePart" && secondNode.name == "snake" {
            self.removeAllChildren()
            gameOver()
        }
        else if firstNode.name == "food" && secondNode.name == "snake" {
            firstNode.removeFromParent()
            score += 1
            newPart()
            food()
        }
        
    }
    
    //MARK: gameOver
    func gameOver(){
        timer.invalidate()
        let label = SKLabelNode(text: "Score: \(score)\n\nGame Over\n\nTap here to restart")
        label.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        label.fontSize = 45
        label.numberOfLines = 4
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.name = "Over"
        addChild(label)
        lastMove = "nil"
    }
    
    
    
    
}