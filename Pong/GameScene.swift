//
//  GameScene.swift
//  Pong
//
//  Created by Karl Petersson on 2018-08-18.
//  Copyright © 2018 Karl Petersson. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var top = SKSpriteNode()
    var bottom = SKSpriteNode()
    var score = [Int]()
    
    var topLabel = SKLabelNode()
    var bottomLabel = SKLabelNode()
    
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        top = self.childNode(withName: "top") as! SKSpriteNode
        bottom = self.childNode(withName: "bottom") as! SKSpriteNode
        topLabel = self.childNode(withName: "topLabel") as! SKLabelNode
        bottomLabel = self.childNode(withName: "bottomLabel") as! SKLabelNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: -30, dy: -30))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        startGame()
        
    }
    
    func startGame(){
        score = [0,0]
        topLabel.text = "\(score[0])"
        bottomLabel.text = "\(score[1])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if currentGameMode == .twoPlayer {
                if location.y > 0 {
                    top.run(SKAction.moveTo(x: location.x, duration: 0.05))
                }
                if location.y < 0 {
                    bottom.run(SKAction.moveTo(x: location.x, duration: 0.05))
                }
            }else{
                bottom.run(SKAction.moveTo(x: location.x, duration: 0.05))
            }        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if currentGameMode == .twoPlayer {
                if location.y > 0 {
                    top.run(SKAction.moveTo(x: location.x, duration: 0.05))
                }
                if location.y < 0 {
                    bottom.run(SKAction.moveTo(x: location.x, duration: 0.05))
                }
            }else{
                bottom.run(SKAction.moveTo(x: location.x, duration: 0.05))
            }
        }
        
        
    }
    
    func addScore(playerWhoScored: SKSpriteNode){
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        if playerWhoScored == top {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 30, dy: 30))
        }else if playerWhoScored == bottom {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -30, dy: -30))
        }
        topLabel.text = "\(score[0])"
        bottomLabel.text = "\(score[1])"
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if currentGameMode == .onePlayer {
            top.run(SKAction.moveTo(x: ball.position.x, duration: 0.8))
        }
        if ball.position.y <= bottom.position.y - 50{
            addScore(playerWhoScored: top)
        }else if ball.position.y >= top.position.y + 50{
            addScore(playerWhoScored: bottom)
        }
    }
    
}
