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

class Lane {
    
    var laneBegining : CGPoint
    var laneNumber : Int
    var cars:[Car] = []
    
    
    init(laneBeginingTemp: CGPoint, laneNumberTemp: Int) {
        
        laneBegining = laneBeginingTemp
        laneNumber = laneNumberTemp
        
    }
    
    init() {
        laneNumber = 0
        laneBegining = CGPoint(x: 0, y: 0)
    }
    
    
    func addCar(carInstance: Car) {
        
        //let laneVarience = CGFloat(Int(arc4random_uniform(15)) - 7)
        
        //laneBegining.y += laneVarience
        
        carInstance.position = laneBegining
        
        if(laneNumber == 1 || laneNumber == 2){
            if(Scenario.funcky != false){
                
            }else{
                carInstance.zRotation = CGFloat(Double.pi)
                carInstance.normal = true
            }
        }else{
            if(Scenario.funcky == false){
                
            }else{
                carInstance.zRotation = CGFloat(Double.pi)
                carInstance.normal = false
            }
        }
        
        cars.append(carInstance)
        
    }
    
    func removerCar(){
        
        cars.removeFirst()
        
    }
    
    func getMaxSpeed() -> Int {
        
        if isEmpty() {
            return 70 //was 65 potentially error prone
        }else{
            
            let frontCar = cars[cars.count-1]
            
//            var distanceToBorder : CGFloat = 0.0
//            
//            
//            if frontCar.normal == true {
//             
//                if frontCar.position.x > 0 {
//                    
//                    distanceToBorder = (Scenario.screenWidth / 2) + frontCar.position.x + CGFloat(frontCar.carWidth / 2)
//                }else{
//                    
//                    distanceToBorder = frontCar.position.x - (Scenario.screenWidth / 2) + CGFloat(frontCar.carWidth / 2)
//                }
//            
//            }else{
//                
//                if frontCar.position.x > 0 {
//                    distanceToBorder = frontCar.position.x - (Scenario.screenWidth / 2) + CGFloat(frontCar.carWidth / 2)
//                }else{
//                    distanceToBorder = -1 * (frontCar.position.x) + (Scenario.screenWidth / 2) + CGFloat(frontCar.carWidth / 2)
//                }
//            
//            }
//            
//            print("distance to end of screen \(distanceToBorder)")
//            
//            let timeLeft = distanceToBorder / CGFloat(frontCar.carSpeed)
//            
//            print("time left on screen \(timeLeft)")
//            
//            let maxSpeed = Scenario.screenWidth / timeLeft
//            
//            print("Theroetical Max Speed: \(maxSpeed)")
            
            
            
            return Int(frontCar.getSpeed() - 5)
        }
        
    }
    
    func getPos() -> CGPoint{
        return laneBegining
    }
    
    func isEmpty() -> Bool {
        if(cars.count == 0){
            return true
        }else{
            return false
        }
    }
    
    func clearLane(){
        
        
        self.cars = []
        
//        let temp = SKNode()
//        
//        let clear = SKAction.run {
//            for tempCar in self.cars {
//                tempCar.removeFromParent()
//                tempCar.removeAllActions()
//                
//            }
//        }
//        
//        let empty = SKAction.run {
//            self.cars = []
//        }
//        
//        let printa = SKAction.run {
//            print(self.isEmpty())
//        }
//        
//        let clearandempty = SKAction.sequence([clear, empty, printa])
//        
//        temp.run(clearandempty)
        
        
        
    }
    
    
    
}
