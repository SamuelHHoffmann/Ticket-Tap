//
//  CustomAlert.swift
//  Ticket Tap
//
//  Created by Samuel Hoffmann on 7/22/17.
//  Copyright © 2017 Samuel Hoffmann. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit
import AudioToolbox

class CustomAlert: SKNode {
    
    @objc var box = SKSpriteNode()
    @objc var header = SKNode()
    @objc var body = SKNode()
    
    @objc init(Header: String, Message: String) {
        super.init()
        
        
        
    }
    
    @objc init(ImageNamed: String) {
        super.init()
        
        self.name = ImageNamed
        
        box = SKSpriteNode(imageNamed: "AlertBox")
        box.setScale(0.40)
        box.position = CGPoint(x: 0, y: 0)
        box.zPosition = 14
        box.alpha = 1
        
        self.addChild(box)
        
        
        body = SKSpriteNode(imageNamed: ImageNamed)
        body.setScale(0.40)
        body.position = CGPoint(x: 0, y: 0)
        body.zPosition = 15
        body.alpha = 1
        
        self.addChild(body)
        
        self.setScale(0.01)
        
    }
    
    
    @objc init(UpdateVersion: Double) {
        super.init()
        
//        if(UpdateVersion == 1.1){
//            
//            body = SKSpriteNode(imageNamed: "\(UpdateVersion)update")
//            body.setScale(0.40)
//            body.position = CGPoint(x: 0, y: 0)
//            body.zPosition = 15
//            
//            
//        }else if(UpdateVersion == 1.2){
//            
//            
//            
//            
//        }else{
//            
//        }
        
        box = SKSpriteNode(imageNamed: "AlertBox")
        box.setScale(0.40)
        box.position = CGPoint(x: 0, y: 0)
        box.zPosition = 14
        box.alpha = 1
        
        self.addChild(box)
        
        
        body = SKSpriteNode(imageNamed: "\(UpdateVersion)update")
        body.setScale(0.40)
        body.position = CGPoint(x: 0, y: 0)
        body.zPosition = 15
        body.alpha = 1
        
        self.addChild(body)
        
        self.setScale(0.01)
        
    }
    
    @objc init(endRound: Int, score: Int, highscore: Bool) {
        super.init()
        
        box = SKSpriteNode(imageNamed: "AlertBox")
        box.setScale(0.40)
        box.position = CGPoint(x: 0, y: 0)
        box.zPosition = 14
        box.alpha = 1
        
        self.addChild(box)
        
        if highscore == true {
            body = SKSpriteNode(imageNamed: "endRound\(endRound)h")
        }else{
            body = SKSpriteNode(imageNamed: "endRound\(endRound)")
        }
        
        body.setScale(0.40)
        body.position = CGPoint(x: 0, y: 0)
        body.zPosition = 15
        body.alpha = 1
        
        if(endRound > 2 || endRound < 1){
            
        }else{
            self.addChild(body)
        }
        
        let scoreLabel = SKLabelNode()
        scoreLabel.text = "\(score)"
        scoreLabel.fontName = "Lucide Grande"
        scoreLabel.fontSize = 140
        scoreLabel.fontColor = UIColor.white
        scoreLabel.setScale(0.40)
        if highscore == true {
            scoreLabel.position = CGPoint(x: 0, y: -10)
        }else{
            scoreLabel.position = CGPoint(x: 0, y: -50)
        }
        
        scoreLabel.zPosition = 16
        scoreLabel.alpha = 1
        
        self.addChild(scoreLabel)
        
        self.setScale(0.01)
        
        
    }
    
    
    
    override init() {
        super.init()
        
        print("gets called")
        
        box = SKSpriteNode(imageNamed: "AlertBox")
        box.setScale(0.40)
        box.position = CGPoint(x: 0, y: 0)
        box.zPosition = 14
        box.alpha = 1
        
        self.addChild(box)
        
        
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}

