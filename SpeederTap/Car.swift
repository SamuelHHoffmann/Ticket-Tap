//
//  Car.swift
//  Ticket Tap
//
//  Created by Samuel Hoffmann on 1/18/17.
//  Copyright © 2017 Samuel Hoffmann. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

class Car: SKNode {
    
    @objc var police = false
    @objc let lights = SKNode()
    @objc var bottomLight = SKSpriteNode()
    @objc var topLight = SKSpriteNode()
    @objc var carSpeed = 0
    @objc var timeCreated = 0
    var lane = Lane()
    @objc var carWidth = 0
    @objc var carHeight = 0
    @objc var normal = false // true = car drives to left : false = car drives to right
    
    @objc init(Police: Bool) {
        super.init()
        
        police = Police
        
        makeCar()
        
        StartSound()
        
        
        
    }
    
    override init() {
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func makeCar(){
        
        var CarBody = SKNode()
        
        if(police == true){
            
            let carBase = SKSpriteNode(imageNamed: "car base")
            
            carBase.zPosition = 0
            
            carBase.run(SKAction.colorize(with: UIColor(red: 256 / 256, green: 256 / 256, blue: 256 / 256, alpha: 1.0), colorBlendFactor: 1, duration: 0))
            
            carBase.setScale(0.40)
            
            CarBody.addChild(carBase)
            
            
            
            let carWireframe = SKSpriteNode(imageNamed: "police wireframe")
            
            carWireframe.zPosition = 2
            
            carWireframe.setScale(0.40)
            
            CarBody.addChild(carWireframe)
            
            
            
            carHeight = Int(carWireframe.frame.height)
            carWidth = Int(carWireframe.frame.width)
            
            let carNumber = SKLabelNode(text: "\(Int(arc4random_uniform(998)) + 1)")
            
            carNumber.fontColor = UIColor.black
            carNumber.fontName = "Lucide Grande"
            carNumber.fontSize = 42
            carNumber.setScale(0.40)
            carNumber.zPosition = 1
            carNumber.zRotation = CGFloat(3 * Double.pi/2)
            
            CarBody.addChild(carNumber)
            
            carNumber.position = CGPoint(x: -carNumber.frame.height, y: 0)
            
            
            
            let sirens1 = SKSpriteNode(imageNamed: "sirens 1")
            
            sirens1.setScale(0.40)
            sirens1.zPosition = 3
            sirens1.alpha = 0
            
            CarBody.addChild(sirens1)
            
//            sirens1.position = CGPoint(x: -sirens1.frame.height, y: 0)
            
            let sirens2 = SKSpriteNode(imageNamed: "sirens 2")
            
            sirens2.setScale(0.40)
            sirens2.zPosition = 3
            sirens2.alpha = 1
            
            CarBody.addChild(sirens2)
            
//            sirens2.position = CGPoint(x: -sirens2.frame.height, y: 0)
            
            let siren1In = SKAction.run {
                sirens1.run(SKAction.fadeIn(withDuration: 0.25))
            }
            
            let siren2In = SKAction.run {
                sirens2.run(SKAction.fadeIn(withDuration: 0.25))
            }
            
            let siren1Out = SKAction.run {
                sirens1.run(SKAction.fadeOut(withDuration: 0.25))
            }
            
            let siren2Out = SKAction.run {
                sirens2.run(SKAction.fadeOut(withDuration: 0.25))
            }
            
            let delay = SKAction.wait(forDuration: 0.05)
            
            let sirensPulse = SKAction.sequence([siren1In,delay,siren2Out,delay,siren1Out,delay,siren2In,delay])
            
            let sirensInfinitePulse = SKAction.repeatForever(sirensPulse)
            
            CarBody.run(sirensInfinitePulse)
            
            CarBody.zPosition = 10
            
            self.addChild(CarBody)
            
        }else{
            
            if Scenario.coloredCars == true {
                
                let carBase = SKSpriteNode(imageNamed: "car base")
                
                carBase.zPosition = 0
                
                carBase.run(SKAction.colorize(with: UIColor(red: CGFloat(arc4random_uniform(256)) / 256, green: CGFloat(arc4random_uniform(256)) / 256, blue: CGFloat(arc4random_uniform(256)) / 256, alpha: 1.0), colorBlendFactor: 1, duration: 0))
                
                carBase.setScale(0.40)
                
                CarBody.addChild(carBase)
                
                
                var carWireframe = SKSpriteNode()
                
                if Scenario.joshF == true {
                    //troll code
                    //carWireframe = SKSpriteNode(imageNamed: "Screen Shot 2018-02-16 at 11.27.09 PM")
                    carWireframe = SKSpriteNode(imageNamed: "car wireframe \(Int(arc4random_uniform(3)) + 1)")
                }else{
                    carWireframe = SKSpriteNode(imageNamed: "car wireframe \(Int(arc4random_uniform(3)) + 1)")
                }
                
                carWireframe.zPosition = 1
                
                carWireframe.setScale(0.40)
                
                CarBody.addChild(carWireframe)
                
                
                
                carHeight = Int(carWireframe.frame.height)
                carWidth = Int(carWireframe.frame.width)
                
                
                
                CarBody.zPosition = 10
                
                self.addChild(CarBody)
                
            }else{
                
                if Scenario.rainbowCars == true {
                    
                    let carBase = SKSpriteNode(imageNamed: "car base (rainbow)")
                    
                    carBase.zPosition = 0
                    
//                    let rainbow = SKAction.colorize(with: UIColor(red: CGFloat(arc4random_uniform(256)) / 256, green: CGFloat(arc4random_uniform(256)) / 256, blue: CGFloat(arc4random_uniform(256)) / 256, alpha: 1.0), colorBlendFactor: 1, duration: 0)
//                    
//                    let delay = SKAction.wait(forDuration: 0.25)
//                    
//                    let colorDelay = SKAction.sequence([rainbow, delay])
//                    
//                    let colordelayforever = SKAction.repeatForever(colorDelay)
//                    
//                    carBase.run(colordelayforever)
//                    
                    carBase.setScale(0.40)
                    
                    CarBody.addChild(carBase)
                    
                    
                    
                    let carWireframe = SKSpriteNode(imageNamed: "car wireframe \(Int(arc4random_uniform(3)) + 1)")
                    
                    carWireframe.zPosition = 1
                    
                    carWireframe.setScale(0.40)
                    
                    CarBody.addChild(carWireframe)
                    
                    
                    
                    carHeight = Int(carWireframe.frame.height)
                    carWidth = Int(carWireframe.frame.width)
                    
                    
                    
                    CarBody.zPosition = 10
                    
                    self.addChild(CarBody)
                    
                }else{
                
                    if Scenario.solar {
                        let carBase = SKSpriteNode(imageNamed: "tesla car base")
                        
                        carBase.zPosition = 0
                        
                        carBase.run(SKAction.colorize(with: UIColor(red: CGFloat(arc4random_uniform(256)) / 256, green: CGFloat(arc4random_uniform(256)) / 256, blue: CGFloat(arc4random_uniform(256)) / 256, alpha: 1.0), colorBlendFactor: 1, duration: 0))
                        
                        carBase.setScale(0.40)
                        
                        CarBody.addChild(carBase)
                        
                        
                        let carWireframe = SKSpriteNode(imageNamed: "tesla car wireframe")
                        
                        
                        carWireframe.zPosition = 1
                        
                        carWireframe.setScale(0.40)
                        
                        CarBody.addChild(carWireframe)
                        
                        
                        
                        carHeight = Int(carWireframe.frame.height)
                        carWidth = Int(carWireframe.frame.width)
                        
                        
                        
                        CarBody.zPosition = 10
                        
                        self.addChild(CarBody)
                        
                    }else{
                        CarBody = SKSpriteNode(imageNamed: "\(Int(arc4random_uniform(4) + 1))")
                        
                        CarBody.setScale(0.40)
                        CarBody.zPosition = 10
                        
                        carHeight = Int(CarBody.frame.height)
                        carWidth = Int(CarBody.frame.width)
                        
                        
                        self.addChild(CarBody)
                    }
                    
                }
            
            }
            
            
            
            
        }
        
        
        if(Scenario.night == true){
            
            bottomLight = SKSpriteNode(imageNamed: "halfYellowLight")
            bottomLight.setScale(0.40)
            bottomLight.zPosition = 15
            bottomLight.position.y -= CGFloat((carHeight/2 ) - 5)
            
            bottomLight.name = "Light"
            
            lights.addChild(bottomLight)
            
            topLight = SKSpriteNode(imageNamed: "tophalfYellowLight")
            topLight.setScale(0.40)
            topLight.zPosition = 15
            topLight.position.y += CGFloat((carHeight/2) - 5)
            lights.addChild(topLight)
            
            topLight.name = "Light"
            
            print(CarBody.frame.height)
            print(CarBody.frame.width)
            
            lights.position = CGPoint(x: CGFloat(carWidth)/2 + topLight.frame.width/2 - 10, y: 0)
            
            lights.name = "car lights"
            
            self.addChild(lights)
            
        }else{
            
            
            
            
        }
        
        
        
    }
    
    
    @objc func makeLightsFade(){
        
        let fadeout = SKAction.run {
            self.bottomLight.run(SKAction.fadeOut(withDuration: 0.25))
        }
        
        let fadein = SKAction.run {
            self.bottomLight.run(SKAction.fadeIn(withDuration: 0.10))
        }
        
        let fade = SKAction.sequence([fadeout, SKAction.wait(forDuration: 0.10 * Double(arc4random_uniform(4))), fadein, SKAction.wait(forDuration: 0.10 * Double(arc4random_uniform(4)))])
        
        bottomLight.run(SKAction.repeatForever(fade))
        
        
    }
    
    
    @objc func CarTapped(pos: CGPoint){
        
        
        
        
    }
    
    
    @objc func postionInScreen() -> CGPoint{
        
        return self.position
        
    }
    
    
    
    @objc func setCarSpeed(speed1: Int){
        carSpeed = speed1
    }
    
    @objc func getSpeed() -> Int {
        return carSpeed
    }
    
    @objc func StartSound(){
        
    }
    
    @objc func pauseSound(){
        
    }
    
    @objc func stopSound(){
        
    }
    
    
    
    
    
    
    
}
