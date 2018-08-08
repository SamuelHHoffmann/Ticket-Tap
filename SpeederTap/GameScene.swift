//
//  GameScene.swift
//  SpeederTap
//
//  Created by Samuel Hoffmann on 12/8/16.
//  Copyright © 2016 Samuel Hoffmann. All rights reserved.
//

//


import SpriteKit
import GameplayKit
import Foundation
import AudioToolbox
import UIKit

class GameScene: SKScene {
    
    var gameStarted = false
    
    var label1 = SKSpriteNode()
    var label2 = SKSpriteNode()
    var label3 = SKSpriteNode()
    var settingButton = SKSpriteNode()
    var highscoreNode = SKSpriteNode()
    var highscoreNodeLabel = SKLabelNode()
    
    var speedLimitLabel = SKLabelNode()
    var ticketsLimit = SKLabelNode()
    
    var speedlimit = 0
    var tickets = 0
    
    var easyHighscore = 0
    var mediumHighscore = 0
    var hardHighscore = 0
    
    
    var difficulty = 0 // 0 == easy 1 == medium 2 == hard 3 == random
    var penalties = 0
    
    var penaltyDot1 = SKSpriteNode()
    var penaltyDot2 = SKSpriteNode()
    var penaltyDot3 = SKSpriteNode()
    
    var lanes:[Lane] = []
    
    var lane1 = Lane()
    var lane2 = Lane()
    var lane3 = Lane()
    var lane4 = Lane()
    
    var delayTime = 5
    var carAmount = 0
    
    var moveAndRemoveLeft = SKAction()
    var moveAndRemoveRight = SKAction()
    
    var car = Car()
    var label4 = SKSpriteNode()
    
    var carRemoved = false
    var settingsTapped = false
    var InfoTapped = false
    var MoneyTapped = false
    var questionsTapped = false
    var mainSubOpen = false
    
    var settingsBackground = SKShapeNode()
    var moneyButton = SKSpriteNode()
    var questionButton = SKSpriteNode()
    var infoButton = SKSpriteNode()
    
    var label5 = SKSpriteNode()
    var label6 = SKSpriteNode()
    var emailButton = SKSpriteNode()
    var facebookButton = SKSpriteNode()
    var twitterButton = SKSpriteNode()
    
    var label22 = SKSpriteNode()
    var label23 = SKSpriteNode()
    var label24 = SKSpriteNode()
    
    var easyButton = SKLabelNode()
    var mediumButton = SKLabelNode()
    var hardButton = SKLabelNode()
    var difficultyLabel = SKSpriteNode()
    
    var label7 = SKSpriteNode()
    var label8 = SKSpriteNode()
    var label9 = SKSpriteNode()
    var label10 = SKSpriteNode()
    var label11 = SKSpriteNode()
    var speedLimitSprite = SKSpriteNode(imageNamed: "smallSpeedLimit")
    var ticketsSprite = SKSpriteNode(imageNamed: "smallTickets")
    
    var demoPlaying = false
    var label12 = SKSpriteNode()
    var label13 = SKSpriteNode()
    var label14 = SKSpriteNode()
    
    var label15 = SKSpriteNode()
    var label16 = SKSpriteNode()
    var label17 = SKSpriteNode()
    
    var label18 = SKSpriteNode()
    var label19 = SKSpriteNode()
    var label20 = SKSpriteNode()
    var label21 = SKSpriteNode()
    
    var demoPart = 0
    var part1 = SKAction()
    var part2 = SKAction()
    var part3 = SKAction()
    var part4 = SKAction()
    var delay = SKAction()
    
    var comingSoonLabel = SKSpriteNode()
    
    var versionLabel = SKLabelNode()
    var alert = SKNode()
    var alertCount = 0
    
    var pauseButton = SKSpriteNode()
    var playButton = SKSpriteNode()
    
    var exitRoundButton = SKSpriteNode()
    
    var snow:[SKShapeNode] = []
    
    var screenWidth:Double = 0.0
    var screenHeight:Double = 0.0
    
    func setUpScene(){
        
        //set up lanes
        
        lane1 = Lane(laneBeginingTemp: CGPoint(x: self.frame.height/4, y: self.frame.width/6 + self.frame.width/20), laneNumberTemp: 1)
        lane2 = Lane(laneBeginingTemp: CGPoint(x: self.frame.height/4, y: self.frame.width/8 - self.frame.width/22), laneNumberTemp: 2)
        lane3 = Lane(laneBeginingTemp: CGPoint(x: -self.frame.height/4, y: -self.frame.width/8 + self.frame.width/22), laneNumberTemp: 3)
        lane4 = Lane(laneBeginingTemp: CGPoint(x: -self.frame.height/4, y: -self.frame.width/6 - self.frame.width/20), laneNumberTemp: 4)
        
        lanes.append(lane1)
        lanes.append(lane2)
        lanes.append(lane3)
        lanes.append(lane4)
        
        if Scenario.grass {
            //:)
            let grass = SKSpriteNode(imageNamed: "grass")
            
            grass.setScale(0.40)
            grass.position = CGPoint(x: 0, y: 0)
            grass.zPosition = 0
            
            self.addChild(grass)
            
        }
        
        if Scenario.solar {
            
            let background = SKSpriteNode(imageNamed: "solarBackground")
            background.setScale(0.40)
            background.position = CGPoint(x: 0, y: 0)
            background.zPosition = 0
            
            self.addChild(background)
            
            
        }else{
            
            //no lines if solar
            
            let median = SKSpriteNode(imageNamed: "median")
            
            median.setScale(0.40)
            median.position = CGPoint(x: 0, y: 0)
            median.zPosition = 0
            
            self.addChild(median)
            
            
            let topLaneSplit = SKSpriteNode(imageNamed: "dotted line")
            
            topLaneSplit.setScale(0.40)
            topLaneSplit.position = CGPoint(x: 0, y: self.frame.width/6 - topLaneSplit.size.height)
            topLaneSplit.zPosition = 0
            
            self.addChild(topLaneSplit)
            
            
            let bottomLaneSplit = SKSpriteNode(imageNamed: "dotted line")
            
            bottomLaneSplit.setScale(0.40)
            bottomLaneSplit.position = CGPoint(x: 0, y: -self.frame.width/6 + topLaneSplit.size.height)
            bottomLaneSplit.zPosition = 0
            
            self.addChild(bottomLaneSplit)
            
        }
        
        
        
        //start test code
        
        
        if Scenario.snowing == true {
            
            let makeSnow = SKAction.run {
                for _ in 1...1000 {
                    
                    let square = SKShapeNode(rect: CGRect(x: Int(arc4random_uniform(1000))-500, y: Int(arc4random_uniform(1000))-500, width: 2, height: 2))
                    
                    square.fillColor = UIColor.white
                    
                    square.alpha = 0.5
                    
                    self.snow.append(square)
                    
                    self.addChild(square)
                    
                }
            }
            
            let clearLanes = SKAction.run {
                for lane in self.lanes {
                    for tempcar in lane.cars {
                        for snowflake in self.nodes(at: tempcar.position) {
                            if snowflake.name == "snowflake"{
                                snowflake.removeFromParent()
                            }
                        }
                    }
                }
            }
            
            let delay = SKAction.wait(forDuration: 10)
            
            let snowAndPlow = SKAction.sequence([makeSnow, delay, clearLanes])
            
            self.run(SKAction.repeatForever(snowAndPlow))
            
        }
        
        //end test code
        
        //add puddles for raining scenario
        
        if Scenario.raining == 0 {
            
        }else{
            for _ in 1...Scenario.raining {
                
                let puddle = SKSpriteNode(imageNamed: "puddle_1") //"_1" for expansion of other random puddle types
                
                puddle.setScale(0.40)
                puddle.zPosition = 1
                //puddle.zRotation = CGFloat(Double.pi / Double(arc4random_uniform(2) + 2))
                puddle.alpha = 1
                
                
                puddle.position = CGPoint(x: CGFloat(arc4random_uniform(UInt32((self.view?.frame.width)! - (puddle.frame.width * 2)))) - CGFloat(((self.view?.frame.width)! / 2) - puddle.frame.width), y: CGFloat(arc4random_uniform(UInt32((self.view?.frame.height)! - (puddle.frame.height * 2)))) - CGFloat(((self.view?.frame.height)! / 2) - puddle.frame.height))
                
                self.addChild(puddle)
                
                
            }
        }
        
        
        
        
        //make scene night time
        
        if Scenario.night == true {
            
            let darkness = SKShapeNode(rectOf: CGSize(width: self.frame.width, height: self.frame.height))
            darkness.position = CGPoint(x: 0, y: 0)
            darkness.fillColor = (scene?.backgroundColor)!
            darkness.lineWidth = 0
            darkness.zPosition = 11
            
            addChild(darkness)
            
            darkness.alpha = 0.65
            
        }
        
        //background set up
        
        //start playing music
        
    }
    
    func setUpLabels(){
        
        label1 = SKSpriteNode(imageNamed: "Ticket Tap")
        
        label1.setScale(0.40)
        label1.position = CGPoint(x: 0, y: self.frame.width/12)
        label1.zPosition = 3
        
        addChild(label1)
        
        
        label2 = SKSpriteNode(imageNamed: "Tap anywhere to begi")
        
        label2.setScale(0.40)
        label2.position = CGPoint(x: 0, y: -self.frame.width/12)
        label2.zPosition = 3
        
        addChild(label2)
        
        
        label3 = SKSpriteNode(imageNamed: "a Samuel Hoffmann ga")
        
        label3.setScale(0.40)
        label3.position = CGPoint(x: 20+self.frame.height/6, y: self.frame.width/22)
        label3.zPosition = 3
        
        addChild(label3)
        
        label4 = SKSpriteNode(imageNamed: "The current speed li")
        
        label4.setScale(0.40)
        label4.position = CGPoint(x: 0, y: self.frame.width/6 + self.frame.width/16)
        label4.zPosition = 3
        
        label4.alpha = 0
        
        self.addChild(label4)
        
        
        
        settingButton = SKSpriteNode(imageNamed: "settings image")
        
        settingButton.name = "settings image"
        settingButton.setScale(0.40)
        settingButton.position = CGPoint(x: self.frame.height/6 + self.frame.height/12, y: -self.frame.width/6 - self.frame.width/20)
        settingButton.zPosition = 3
        
        
        addChild(settingButton)
        
        
        
        label7 = SKSpriteNode(imageNamed: "Every round a random")
        label7.setScale(0.40)
        label7.zPosition = 12
        label7.alpha = 0
        
        addChild(label7)
        
        
        label8 = SKSpriteNode(imageNamed: "Tickets are your poi")
        label8.setScale(0.40)
        label8.zPosition = 12
        label8.alpha = 0
        
        addChild(label8)
        
        
        label9 = SKSpriteNode(imageNamed: "If you tap a car whi")
        label9.setScale(0.40)
        label9.zPosition = 12
        label9.alpha = 0
        
        addChild(label9)
        
        
        label10 = SKSpriteNode(imageNamed: "Hit 4 penalties and")
        label10.setScale(0.40)
        label10.zPosition = 12
        label10.alpha = 0
        
        addChild(label10)
        
        
        label11 = SKSpriteNode(imageNamed: "In the settings tab,")
        label11.setScale(0.40)
        label11.zPosition = 12
        label11.alpha = 0
        
        addChild(label11)
        
        
        label12 = SKSpriteNode(imageNamed: "demo in progress, pl")
        label12.setScale(0.40)
        label12.zPosition = 12
        label12.alpha = 0
        
        addChild(label12)
        
        
        label13 = SKSpriteNode(imageNamed: "This is your highsco")
        label13.setScale(0.40)
        label13.zPosition = 12
        label13.alpha = 0
        
        addChild(label13)
        
        
        label14 = SKSpriteNode(imageNamed: "You can change your")
        label14.setScale(0.40)
        label14.zPosition = 12
        label14.alpha = 0
        
        addChild(label14)
        
        
        label15 = SKSpriteNode(imageNamed: "highscore node")
        label15.setScale(0.40)
        label15.zPosition = 12
        label15.position = CGPoint(x: -self.frame.height/6 - self.frame.height/22 - 20, y: -self.frame.width/6 + 10)
        label15.alpha = 0
        
        addChild(label15)
        
        
        label16 = SKSpriteNode(imageNamed: "tickets")
        label16.setScale(0.40)
        label16.zPosition = 12
        label16.position = CGPoint(x: -self.frame.height/6 - self.frame.height/22 - 20 , y: self.frame.width/6 - 10)
        label16.alpha = 0
        
        addChild(label16)
        
        
        label17 = SKSpriteNode(imageNamed: "speed Limit")
        label17.setScale(0.40)
        label17.zPosition = 12
        label17.position = CGPoint(x: -self.frame.height/6 - self.frame.height/22 - 20, y: self.frame.width/6 - 10)
        label17.alpha = 0
        
        addChild(label17)
        
        
        label18 = SKSpriteNode(imageNamed: "This is the speed li")
        label18.setScale(0.40)
        label18.zPosition = 12
        label18.position = CGPoint(x: 0, y: self.lane2.getPos().y)
        label18.alpha = 0
        
        addChild(label18)
        
        
        label19 = SKSpriteNode(imageNamed: "Police cars are neve")
        label19.setScale(0.40)
        label19.zPosition = 12
        label19.position = CGPoint(x: 0, y: self.lane3.getPos().y)
        label19.alpha = 0
        
        addChild(label19)
        
        
        label20 = SKSpriteNode(imageNamed: "Your tickets are you")
        label20.setScale(0.40)
        label20.zPosition = 12
        label20.position = CGPoint(x: 0, y: self.lane2.getPos().y)
        label20.alpha = 0
        
        addChild(label20)
        
        
        label21 = SKSpriteNode(imageNamed: "If you hit a car whi")
        label21.setScale(0.40)
        label21.zPosition = 12
        label21.position = CGPoint(x: 0, y: self.lane3.getPos().y)
        label21.alpha = 0
        
        addChild(label21)
        
        
        comingSoonLabel = SKSpriteNode(imageNamed: "comingSoon")
        comingSoonLabel.zPosition = 12
        comingSoonLabel.alpha = 0
        comingSoonLabel.setScale(0.40)
        
        addChild(comingSoonLabel)
        
        versionLabel.text = "Version: \(Scenario.version)"
        versionLabel.name = "versionLabel"
        versionLabel.fontName = "Lucide Grande"
        versionLabel.fontSize = 40
        versionLabel.fontColor = UIColor.white
        versionLabel.setScale(0.40)
        screenWidth = Double(self.frame.width)
        versionLabel.position = CGPoint(x: 0, y: -screenWidth*5.26041667)
        versionLabel.zPosition = 12
        versionLabel.alpha = 0
        
        addChild(versionLabel)
        
        
    }
    
    func setUpInfoButtons(){
        
        
        
        speedLimitSprite.setScale(0.40)
        speedLimitSprite.name = "speedLimitSprite"
        speedLimitSprite.position = CGPoint(x: -self.frame.height/6 - self.frame.height/12, y: self.frame.width/6 + self.frame.width/16)
        speedLimitSprite.zPosition = 3
        
        
        addChild(speedLimitSprite)
        
        
        
        
        ticketsSprite.setScale(0.40)
        ticketsSprite.name = "ticketsSprite"
        ticketsSprite.position = CGPoint(x: -self.frame.height/6 - self.frame.height/22, y: self.frame.width/6 + self.frame.width/16)
        ticketsSprite.zPosition = 3
        
        
        addChild(ticketsSprite)
        
        
        speedLimitLabel.text = "\(speedlimit)"
        speedLimitLabel.name = "speedLimitLabel"
        speedLimitLabel.fontName = "Lucide Grande"
        speedLimitLabel.fontSize = 75
        speedLimitLabel.fontColor = UIColor.black
        speedLimitLabel.setScale(0.40)
        speedLimitLabel.position = CGPoint(x: -self.frame.height/6 - self.frame.height/12, y: self.frame.width/6 + self.frame.width/32)
        speedLimitLabel.zPosition = 4
        
        addChild(speedLimitLabel)
        
        
        ticketsLimit.text = "\(tickets)"
        ticketsLimit.name = "ticketsLimit"
        ticketsLimit.fontName = "Lucide Grande"
        ticketsLimit.fontSize = 75
        ticketsLimit.fontColor = UIColor.black
        ticketsLimit.setScale(0.40)
        ticketsLimit.position = CGPoint(x: -self.frame.height/6 - self.frame.height/22, y: self.frame.width/6 + self.frame.width/32)
        ticketsLimit.zPosition = 4
        
        addChild(ticketsLimit)
        
        
        //highscore node
        
        
        highscoreNode = SKSpriteNode(imageNamed: "highscore_node_small")
    
        highscoreNode.name = "highscoreNode"
        highscoreNode.setScale(0.40)
        highscoreNode.position = CGPoint(x: -self.frame.height/6 - self.frame.height/12, y: -self.frame.width/6 - self.frame.width/16)
        highscoreNode.zPosition = 3
    
    
        addChild(highscoreNode)
        
        
        
        if(difficulty == 0){
            
            highscoreNodeLabel.text = "\(easyHighscore)"
            //highscoreNodeLabel.fontColor = UIColor(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
            highscoreNodeLabel.fontColor = UIColor(red: 0/255, green: 196/255, blue: 37/255, alpha: 1)
            
        }else if(difficulty == 1){
            
            highscoreNodeLabel.text = "\(mediumHighscore)"
            highscoreNodeLabel.fontColor = UIColor(red: 245/255, green: 185/255, blue: 35/255, alpha: 1)
            
        }else{
            
            highscoreNodeLabel.text = "\(hardHighscore)"
            highscoreNodeLabel.fontColor = UIColor(red: 184/255, green: 0/255, blue: 0/255, alpha: 1)
            
            
        }
        
        
        highscoreNodeLabel.fontSize = 75
        highscoreNodeLabel.name = "highscoreNodeLabel"
        //highscoreNodeLabel.fontColor = UIColor.black
        highscoreNodeLabel.fontName = "Lucide Grande"
        highscoreNodeLabel.setScale(0.40)
        highscoreNodeLabel.position = CGPoint(x: -self.frame.height/6 - self.frame.height/12, y: -self.frame.width/6 - self.frame.width/16 - self.frame.width/40)
        highscoreNodeLabel.zPosition = 4
        
        addChild(highscoreNodeLabel)
            
          
        updateHighscore(afterRound: false, ingoreOne: false)
        
        
        
        
        
        
        
        
        
        
        //set up penalty dots
        
        penaltyDot1 = SKSpriteNode(imageNamed: "penaltyDot")
        penaltyDot1.setScale(0.40)
        penaltyDot1.position = CGPoint(x: -self.frame.height/6 - self.frame.height/50, y: self.frame.width/6 + self.frame.width/16 + self.frame.width/32)
        penaltyDot1.zPosition = 4
        
        addChild(penaltyDot1)
        
        
        penaltyDot2 = SKSpriteNode(imageNamed: "penaltyDot")
        penaltyDot2.setScale(0.40)
        penaltyDot2.position = CGPoint(x: -self.frame.height/6, y: self.frame.width/6 + self.frame.width/16 + self.frame.width/32)
        penaltyDot2.zPosition = 4
        
        addChild(penaltyDot2)
        
        
        penaltyDot3 = SKSpriteNode(imageNamed: "penaltyDot")
        penaltyDot3.setScale(0.40)
        penaltyDot3.position = CGPoint(x: -self.frame.height/6 + self.frame.height/50, y: self.frame.width/6 + self.frame.width/16 + self.frame.width/32)
        penaltyDot3.zPosition = 4
        
        addChild(penaltyDot3)
        
        
        penaltyDot1.alpha = 0
        penaltyDot2.alpha = 0
        penaltyDot3.alpha = 0
        
        
        
        //set up pause and play buttons 
        
        pauseButton = SKSpriteNode(imageNamed: "pause")
        
        pauseButton.name = "pauseButton"
        pauseButton.setScale(0.40)
        pauseButton.position = CGPoint(x: self.frame.height/6 + self.frame.height/12, y: lane1.getPos().y)
        pauseButton.zPosition = 3
        pauseButton.alpha = 0
        
        addChild(pauseButton)
        
        
        playButton = SKSpriteNode(imageNamed: "play")
        
        playButton.name = "playButton"
        playButton.setScale(0.40)
        playButton.position = CGPoint(x: self.frame.height/6 + self.frame.height/12, y: lane1.getPos().y)
        playButton.zPosition = 12
        playButton.alpha = 0
        
        addChild(playButton)
        
        
        
        exitRoundButton = SKSpriteNode(imageNamed: "exitRoundImage")
        
        exitRoundButton.name = "exitButton"
        exitRoundButton.setScale(0.40)
        exitRoundButton.position = settingButton.position
        exitRoundButton.zPosition = 12
        exitRoundButton.alpha = 0
        
        addChild(exitRoundButton)
        
        
    }
    
    
    func uploadData(){
        UserDefaults.standard.set(difficulty, forKey: "diffculty")
    }
    
    
    func downloadData(){
        difficulty = UserDefaults.standard.integer(forKey: "diffculty")
        
        if Scenario.version != UserDefaults.standard.double(forKey: "VersionNumber") {
            
            print("Log: versions out of sync")
            versionUpdateHandler()
            
        }else{
            
            print("versions in sync")
            presentRandomNotificaiton()
            
        }
        
    }
    
    
    func versionUpdateHandler(){
        let current = UserDefaults.standard.double(forKey: "VersionNumber")
        
        if(current == 0){
            
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "uploadHighscore"), object: nil)
            
            UserDefaults.standard.set(1.1, forKey: "VersionNumber")
            
            print("Log: updated 1.1")
            
            versionUpdateHandler()
            
        }else if(current == 1.1){
            
            UserDefaults.standard.set(1.2, forKey: "VersionNumber")
            
            print("Log: updated 1.2")
            
            versionUpdateHandler()
            
        }else if(current == 1.2){
            
            UserDefaults.standard.set(1.3, forKey: "VersionNumber")
            
            print("Log: updated 1.3")
            
            versionUpdateHandler()
            
        }else if(current == 1.3){
            
            UserDefaults.standard.set(1.4, forKey: "VersionNumber")
            
            print("Log: updated 1.4")
            
            versionUpdateHandler()
            
        }else if(current == 1.4){
            
            UserDefaults.standard.set(1.5, forKey: "VersionNumber")
            
            print("Log: updated 1.5")
            
            versionUpdateHandler()
            
        }else if(current == 1.5){
            
            UserDefaults.standard.set(1.6, forKey: "VersionNumber")
            
            difficulty = 2
            uploadData()
            downloadData()
            
            print("Log: updated 1.6")
            
            versionUpdateHandler()
            
        }else if(current == 1.6){
            
            UserDefaults.standard.set(1.7, forKey: "VersionNumber")
            
            print("Log: updated 1.7")
            
            versionUpdateHandler()
            
        }else if(current == 1.7){
            
            UserDefaults.standard.set(1.8, forKey: "VersionNumber")
            
            difficulty = 1
            uploadData()
            downloadData()
            
            print("Log: updated 1.8")
            
            versionUpdateHandler()
            
        }else if(current == 1.8){
            
            UserDefaults.standard.set(1.9, forKey: "VersionNumber")
            
            difficulty = 1
            uploadData()
            downloadData()
            
            print("Log: updated 1.9")
            
            versionUpdateHandler()
            
        }else{
            //all up to date
            
            if Scenario.inAlert == true {
                //cant make more than one alert
            }else{
            
                if(UserDefaults.standard.bool(forKey: "notFirstTime") == true){
                
                    Scenario.inAlert = true
                    
                    alertCount += 1
                    
                    alert = CustomAlert(UpdateVersion: current)
                    
                    addChild(alert)
                    
                    alert.run(SKAction.scale(to: 1, duration: 0.15))
                }else{
                    Scenario.inAlert = true
                    
                    alertCount += 1
                    
                    alert = CustomAlert(ImageNamed: "welcomeMessage")
                    
                    addChild(alert)
                    
                    alert.run(SKAction.scale(to: 1, duration: 0.15))
                }
            
            }
            
            print("Log: up to date")
        }
        
    }
    
    
    
    
    
    
    override func didMove(to view: SKView) {
        
        Scenario.screenWidth = (self.view?.frame.width)!
        
        
        
        setUpScene()
        
        setUpLabels()
        
        setUpSettings()
        
        setUpInfoButtons()
        
        
       
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameScene.UnPause), name: NSNotification.Name(rawValue: "play"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameScene.UnPauseEndRound), name: NSNotification.Name(rawValue: "endRound"), object: nil)
        
        //remove for testing a production

        //UserDefaults.standard.set(false, forKey: "notFirstTime")
        
        
        //print(UserDefaults.standard.integer(forKey: "Easyhighscore"))
        //print(UserDefaults.standard.integer(forKey: "mediumHighscore"))
        //print(UserDefaults.standard.integer(forKey: "hardHighscore"))
        
        
        
        if(difficulty == 3){
            sendCar(speed: Int(arc4random_uniform(3)), forever: true, police: false, demo: true)
        }else{
            sendCar(speed: Int(difficulty), forever: true, police: false, demo: true)
        }
        
        
        //set up titles
        //print("game loaded")
        
    }
    
    func clearAppData(){
        
        //TODO: update to clear new data fields
        
        UserDefaults.standard.set(0, forKey: "Easyhighscore")
        UserDefaults.standard.set(0, forKey: "mediumHighscore")
        UserDefaults.standard.set(0, forKey: "hardHighscore")
        UserDefaults.standard.set(false, forKey: "notFirstTime")
        UserDefaults.standard.set(0, forKey: "diffculty")
        
        
         gameStarted = false
        
         label1 = SKSpriteNode()
         label2 = SKSpriteNode()
         label3 = SKSpriteNode()
         settingButton = SKSpriteNode()
         highscoreNode = SKSpriteNode()
         highscoreNodeLabel = SKLabelNode()
        
         speedLimitLabel = SKLabelNode()
         ticketsLimit = SKLabelNode()
        
         speedlimit = 0
         tickets = 0
        
         easyHighscore = 0
         mediumHighscore = 0
         hardHighscore = 0
        
        
         difficulty = 0 // 0 == easy 1 == medium 2 == hard 3 == random
         penalties = 0
        
         penaltyDot1 = SKSpriteNode()
         penaltyDot2 = SKSpriteNode()
         penaltyDot3 = SKSpriteNode()
        
         lane1 = Lane()
         lane2 = Lane()
         lane3 = Lane()
         lane4 = Lane()
        
         delayTime = 5
         carAmount = 0
        
         moveAndRemoveLeft = SKAction()
         moveAndRemoveRight = SKAction()
        
         car = Car()
         label4 = SKSpriteNode()
        
         carRemoved = false
         settingsTapped = false
         InfoTapped = false
         MoneyTapped = false
         questionsTapped = false
        
        
         settingsBackground = SKShapeNode()
         moneyButton = SKSpriteNode()
         questionButton = SKSpriteNode()
         infoButton = SKSpriteNode()
        
         label5 = SKSpriteNode()
         label6 = SKSpriteNode()
         emailButton = SKSpriteNode()
         facebookButton = SKSpriteNode()
         twitterButton = SKSpriteNode()
        
         label22 = SKSpriteNode()
         label23 = SKSpriteNode()
         label24 = SKSpriteNode()
        
         easyButton = SKLabelNode()
         mediumButton = SKLabelNode()
         hardButton = SKLabelNode()
         difficultyLabel = SKSpriteNode()
        
        
        
        
        
        
        self.removeAllActions()
        self.removeAllChildren()
        
        setUpScene()
        
        setUpLabels()
        
        setUpSettings()
        
        setUpInfoButtons()
        
        
        
        if(difficulty == 3){
            sendCar(speed: Int(arc4random_uniform(3)), forever: true, police: false, demo: true)
        }else{
            sendCar(speed: Int(difficulty), forever: true, police: false, demo: true)
        }
        
        
        
        
        
    }
    
    
    
    
    
    func updateHighscore(afterRound: Bool, ingoreOne: Bool){
        
        
      //print(UserDefaults.standard.integer(forKey: "Easyhighscore"))
      //print(UserDefaults.standard.integer(forKey: "mediumHighscore"))
      //print(UserDefaults.standard.integer(forKey: "hardHighscore"))
        
        if(difficulty == 0){
            
            easyHighscore = UserDefaults.standard.integer(forKey: "Easyhighscore")
            
          //print("0/0")
            
            if(afterRound == true){
                if(easyHighscore < tickets){
                  //print("0/1")
                    easyHighscore = tickets
                    UserDefaults.standard.set(easyHighscore, forKey: "Easyhighscore")
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "uploadHighscore"), object: nil)
                    
                    if Scenario.inAlert == true {
                        //cant make more than one alert
                    }else{
                        
                        Scenario.inAlert = true
                        
                        alertCount += 1
                        
                        alert = CustomAlert(endRound: 2, score: tickets, highscore: true)
                        
                        addChild(alert)
                        
                        alert.run(SKAction.scale(to: 1, duration: 0.15))
                    }
                    
                }else{
                    
                    if Scenario.inAlert == true {
                        //cant make more than one alert
                    }else{
                    
                        Scenario.inAlert = true
                        
                        alertCount += 1
                        
                        alert = CustomAlert(endRound: 2, score: tickets, highscore: false)
                        
                        addChild(alert)
                        
                        alert.run(SKAction.scale(to: 1, duration: 0.15))
                    }
                }
            }
            
            if(easyHighscore > 0){
                
                if(ingoreOne == false){
                    highscoreNode.alpha = 1
                    highscoreNodeLabel.alpha = 1
                }
                highscoreNodeLabel.text = "\(easyHighscore)"
                highscoreNodeLabel.fontColor = UIColor(red: 0/255, green: 196/255, blue: 37/255, alpha: 1)
               
              //print("0/2")
                
            }else{
                
                if(ingoreOne == true){
                    highscoreNodeLabel.text = "\(easyHighscore)"
                    highscoreNodeLabel.fontColor = UIColor(red: 0/255, green: 196/255, blue: 37/255, alpha: 1)
                }else{
                    highscoreNode.alpha = 0
                    highscoreNodeLabel.alpha = 0
                }
                
                
              //print("0/3")
            }
            
        }else if(difficulty == 1){
            
            mediumHighscore = UserDefaults.standard.integer(forKey: "mediumHighscore")
          //print("1/0")
            
            if(afterRound == true){
                if(mediumHighscore < tickets){
                    
                    mediumHighscore = tickets
                    UserDefaults.standard.set(mediumHighscore, forKey: "mediumHighscore")
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "uploadHighscore"), object: nil)
                    
                    if Scenario.inAlert == true {
                        //cant make more than one alert
                    }else{
                    
                        Scenario.inAlert = true
                        
                        alertCount += 1
                        
                        alert = CustomAlert(endRound: 2, score: tickets, highscore: true)
                        
                        addChild(alert)
                        
                        alert.run(SKAction.scale(to: 1, duration: 0.15))
                    }
                    
                }else{
                    
                    if Scenario.inAlert == true {
                        //cant make more than one alert
                    }else{
                    
                        Scenario.inAlert = true
                        
                        alertCount += 1
                        
                        alert = CustomAlert(endRound: 2, score: tickets, highscore: false)
                        
                        addChild(alert)
                        
                        alert.run(SKAction.scale(to: 1, duration: 0.15))
                    }
                }
            }
            
            if(mediumHighscore > 0){
                
                if(ingoreOne == false){
                    highscoreNode.alpha = 1
                    highscoreNodeLabel.alpha = 1
                }
                highscoreNodeLabel.text = "\(mediumHighscore)"
                highscoreNodeLabel.fontColor = UIColor(red: 245/255, green: 185/255, blue: 35/255, alpha: 1)
              //print("1/2")
                
                
            }else{
                
                if(ingoreOne == true){
                    highscoreNodeLabel.text = "\(mediumHighscore)"
                    highscoreNodeLabel.fontColor = UIColor(red: 245/255, green: 185/255, blue: 35/255, alpha: 1)
                }else{
                    highscoreNode.alpha = 0
                    highscoreNodeLabel.alpha = 0
                }
              //print("1/3")
            }
            
        }else{
            
            hardHighscore = UserDefaults.standard.integer(forKey: "hardHighscore")
            //print("2/0")
            
            if(afterRound == true){
                if(hardHighscore < tickets){
                    
                    hardHighscore = tickets
                    UserDefaults.standard.set(hardHighscore, forKey: "hardHighscore")
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "uploadHighscore"), object: nil)
                    
                    if Scenario.inAlert == true {
                        //cant make more than one alert
                    }else{
                    
                        Scenario.inAlert = true
                        
                        alertCount += 1
                        
                        alert = CustomAlert(endRound: 2, score: tickets, highscore: true)
                        
                        addChild(alert)
                        
                        alert.run(SKAction.scale(to: 1, duration: 0.15))
                        
                    }
                    
                }else{
                    
                    if Scenario.inAlert == true {
                        //cant make more than one alert
                    }else{
                    
                        Scenario.inAlert = true
                        
                        alertCount += 1
                        
                        alert = CustomAlert(endRound: 2, score: tickets, highscore: false)
                        
                        addChild(alert)
                        
                        alert.run(SKAction.scale(to: 1, duration: 0.15))
                    }
                }
            }
            
            if(hardHighscore > 0){
                
              //print("2/2")
                
                if(ingoreOne == false){
                    highscoreNode.alpha = 1
                    highscoreNodeLabel.alpha = 1
                }
                highscoreNodeLabel.text = "\(hardHighscore)"
                highscoreNodeLabel.fontColor = UIColor(red: 184/255, green: 0/255, blue: 0/255, alpha: 1)
                
                
                
            }else{
              //print("2/3")
                if(ingoreOne == true){
                    highscoreNodeLabel.text = "\(hardHighscore)"
                    highscoreNodeLabel.fontColor = UIColor(red: 184/255, green: 0/255, blue: 0/255, alpha: 1)
                }else{
                    highscoreNode.alpha = 0
                    highscoreNodeLabel.alpha = 0
                }
            }
            
        }
        
        
      //print(UserDefaults.standard.integer(forKey: "Easyhighscore"))
      //print(UserDefaults.standard.integer(forKey: "mediumHighscore"))
      //print(UserDefaults.standard.integer(forKey: "hardHighscore"))
        
        
    }
    
    
    
    
    func updatePenalties(){
        
        if(penalties == 1){
            penaltyDot1.alpha = 1
        }else if(penalties == 2){
            penaltyDot2.alpha = 1
        }else if(penalties == 3){
            penaltyDot3.alpha = 1
        }else{
            penaltyDot1.alpha = 0
            penaltyDot2.alpha = 0
            penaltyDot3.alpha = 0
        }
        
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        
    }
    
    
    
    func setUpSettings(){
        
        //make background
        settingsBackground = SKShapeNode(rectOf: CGSize(width: self.frame.width, height: self.frame.height))
        settingsBackground.position = CGPoint(x: 0, y: 0)
        settingsBackground.fillColor = (scene?.backgroundColor)!
        settingsBackground.lineWidth = 0
        settingsBackground.zPosition = 11
        
        addChild(settingsBackground)
        
        
        //info button
        
        infoButton = SKSpriteNode(imageNamed: "Info")
        infoButton.name = "infoButt"
        infoButton.setScale(0.40)
        infoButton.position = CGPoint(x: self.frame.height/6 + self.frame.height/12, y: -self.frame.width/6 - self.frame.width/20)
        infoButton.zPosition = 3
        infoButton.alpha = 0
        
        addChild(infoButton)
        
        //money button
        
        moneyButton = SKSpriteNode(imageNamed: "tap")
        moneyButton.name = "MoneyButt"
        moneyButton.setScale(0.40)
        moneyButton.position = CGPoint(x: self.frame.height/6 + self.frame.height/12, y: -self.frame.width/6 - self.frame.width/20)
        moneyButton.zPosition = 3
        moneyButton.alpha = 0
        
        addChild(moneyButton)
        
        //questions button
        
        questionButton = SKSpriteNode(imageNamed: "Gamecenter-icon")
        questionButton.name = "Gamecenter-icon"
        questionButton.setScale(0.40)
        questionButton.position = CGPoint(x: self.frame.height/6 + self.frame.height/12, y: -self.frame.width/6 - self.frame.width/20)
        questionButton.zPosition = 3
        questionButton.alpha = 0
        
        addChild(questionButton)
        
        //make buttons
        
        
        label22 = SKSpriteNode(imageNamed: "tap1")
        label22.setScale(0.40)
        label22.position = CGPoint(x: 0, y: lane2.getPos().y)
        label22.zPosition = 12
        label22.alpha = 0
        
        self.addChild(label22)
        
        label23 = SKSpriteNode(imageNamed: "tap2")
        label23.setScale(0.40)
        label23.position = CGPoint(x: 0, y: lane3.getPos().y)
        label23.zPosition = 12
        label23.alpha = 0
        
        self.addChild(label23)
        
        label24 = SKSpriteNode(imageNamed: "tap3")
        label24.setScale(0.40)
        label24.position = CGPoint(x: 0, y: lane4.getPos().y)
        label24.zPosition = 12
        label24.alpha = 0
        
        self.addChild(label24)
        
        //set up sub settings pages
        
        label5 = SKSpriteNode(imageNamed: "Ticket Tap is an 80’")
        
        label5.setScale(0.40)
        label5.position = CGPoint(x: 0, y: lane2.getPos().y)
        label5.zPosition = 12
        label5.alpha = 0
        
        
        addChild(label5)
        
        label6 = SKSpriteNode(imageNamed: "For questions, comme")
        
        label6.setScale(0.40)
        label6.position = CGPoint(x: 0, y: lane3.getPos().y)
        label6.zPosition = 12
        label6.alpha = 0
        
        addChild(label6)
        
        
        emailButton = SKSpriteNode(imageNamed: "EmailLogo")
        
        emailButton.name = "EmailButton"
        emailButton.setScale(0.40)
        emailButton.position = CGPoint(x: 0, y: lane4.getPos().y)
        emailButton.zPosition = 12
        emailButton.alpha = 0
        
        addChild(emailButton)
        
        
        facebookButton = SKSpriteNode(imageNamed: "FacebookLogo")
        
        facebookButton.name = "facebookButton"
        facebookButton.setScale(0.40)
        facebookButton.position = CGPoint(x: -self.frame.height/12, y: lane4.getPos().y)
        facebookButton.zPosition = 12
        facebookButton.alpha = 0
        
        addChild(facebookButton)
        
        
        
        twitterButton = SKSpriteNode(imageNamed: "TwitterLogo")
        
        twitterButton.name = "twitterButton"
        twitterButton.setScale(0.40)
        twitterButton.position = CGPoint(x: self.frame.height/12, y: lane4.getPos().y)
        twitterButton.zPosition = 12
        twitterButton.alpha = 0
        
        addChild(twitterButton)
        
        
        
        easyButton = SKLabelNode(text: "Easy")
        easyButton.fontSize = 60
        easyButton.fontName = "Lucide Grande"
        easyButton.fontColor = UIColor(red: 188/255, green: 188/255, blue: 188/255, alpha: 1)
        easyButton.name = "EasyButton"
        easyButton.alpha = 0
        easyButton.setScale(0.40)
        easyButton.position = CGPoint(x: -self.frame.height/10, y: lane4.getPos().y)
        easyButton.zPosition = 12
        
        addChild(easyButton)
        
        
        mediumButton = SKLabelNode(text: "Medium")
        mediumButton.fontSize = 60
        mediumButton.fontName = "Lucide Grande"
        mediumButton.fontColor = UIColor(red: 188/255, green: 188/255, blue: 188/255, alpha: 1)
        mediumButton.name = "MediumButton"
        mediumButton.alpha = 0
        mediumButton.setScale(0.40)
        mediumButton.position = CGPoint(x: 0, y: lane4.getPos().y)
        mediumButton.zPosition = 12
        
        addChild(mediumButton)
        
        
        hardButton = SKLabelNode(text: "Hard")
        hardButton.fontSize = 60
        hardButton.fontName = "Lucide Grande"
        hardButton.fontColor = UIColor(red: 188/255, green: 188/255, blue: 188/255, alpha: 1)
        hardButton.name = "HardButton"
        hardButton.alpha = 0
        hardButton.setScale(0.40)
        hardButton.position = CGPoint(x: self.frame.height/10, y: lane4.getPos().y)
        hardButton.zPosition = 12
        
        addChild(hardButton)
        
        downloadData()
        
        setDifficulty()
        
        
        
        difficultyLabel = SKSpriteNode(imageNamed: "Difficulty:")
        
        difficultyLabel.zPosition = 12
        difficultyLabel.alpha = 0
        difficultyLabel.position = CGPoint(x: 0, y: lane3.getPos().y)
        difficultyLabel.setScale(0.40)
        
        addChild(difficultyLabel)
        
        
        settingsBackground.alpha = 0
        //set all items to alpha = 0
        
    }
    
    func setDifficulty(){
        
        
        
        if(difficulty == 0){
            
            easyButton.fontColor = UIColor(red: 0/255, green: 196/255, blue: 37/255, alpha: 1)
            mediumButton.fontColor = UIColor(red: 188/255, green: 188/255, blue: 188/255, alpha: 1)
            hardButton.fontColor = UIColor(red: 188/255, green: 188/255, blue: 188/255, alpha: 1)
            
            
        }else if(difficulty == 1){
            
            easyButton.fontColor = UIColor(red: 188/255, green: 188/255, blue: 188/255, alpha: 1)
            mediumButton.fontColor = UIColor(red: 245/255, green: 185/255, blue: 35/255, alpha: 1)
            hardButton.fontColor = UIColor(red: 188/255, green: 188/255, blue: 188/255, alpha: 1)
            
        }else if(difficulty == 2){
            
            easyButton.fontColor = UIColor(red: 188/255, green: 188/255, blue: 188/255, alpha: 1)
            mediumButton.fontColor = UIColor(red: 188/255, green: 188/255, blue: 188/255, alpha: 1)
            hardButton.fontColor = UIColor(red: 184/255, green: 0/255, blue: 0/255, alpha: 1)
            
        }else{
            
            
        }
        
        uploadData()
        
        
    }
    
    
    func openSettings(){
        
        //start test code
        
        
        //end test code
        
        settingButton.setScale(0.35)
        
        settingsTapped = true
        
        settingButton.run(SKAction.rotate(toAngle: 90, duration: 0.5))
        
        label1.zPosition = 12
        label3.zPosition = 12
        label3.run(SKAction.moveTo(x: 0, duration: 0.5))
        label2.run(SKAction.fadeOut(withDuration: 0.5))
        
        settingButton.zPosition = 12
        settingsBackground.alpha = 0.85
        
        infoButton.run(SKAction.moveTo(y: lane1.getPos().y, duration: 0.5))
        infoButton.run(SKAction.fadeIn(withDuration: 0.5))
        infoButton.zPosition = 12
        
        moneyButton.run(SKAction.moveTo(y: lane2.getPos().y, duration: 0.5))
        moneyButton.run(SKAction.fadeIn(withDuration: 0.5))
        moneyButton.zPosition = 12
        
        questionButton.run(SKAction.moveTo(y: lane3.getPos().y, duration: 0.5))
        questionButton.run(SKAction.fadeIn(withDuration: 0.5))
        questionButton.zPosition = 12
        
        easyButton.run(SKAction.fadeIn(withDuration: 0.5))
        mediumButton.run(SKAction.fadeIn(withDuration: 0.5))
        hardButton.run(SKAction.fadeIn(withDuration: 0.5))
        difficultyLabel.run(SKAction.fadeIn(withDuration: 0.5))
        
    }
    
    func closeSettings(){
        
        settingButton.setScale(0.35)
        
        settingButton.run(SKAction.rotate(toAngle: 0, duration: 0.5))
        
        settingsBackground.alpha = 0
        settingButton.zPosition = 3
        label1.zPosition = 3
        label3.zPosition = 3
        label3.run(SKAction.moveTo(x: 20+self.frame.height/6, duration: 0.5))
        label2.run(SKAction.fadeIn(withDuration: 1))
        
        infoButton.run(SKAction.moveTo(y: -self.frame.width/6 - self.frame.width/20, duration: 0.5))
        infoButton.run(SKAction.fadeOut(withDuration: 0.5))
        infoButton.zPosition = 3
        
        moneyButton.run(SKAction.moveTo(y: -self.frame.width/6 - self.frame.width/20, duration: 0.5))
        moneyButton.run(SKAction.fadeOut(withDuration: 0.5))
        moneyButton.zPosition = 3
        
        questionButton.run(SKAction.moveTo(y: -self.frame.width/6 - self.frame.width/20, duration: 0.5))
        questionButton.run(SKAction.fadeOut(withDuration: 0.5))
        questionButton.zPosition = 3
        
        
        easyButton.run(SKAction.fadeOut(withDuration: 0.5))
        mediumButton.run(SKAction.fadeOut(withDuration: 0.5))
        hardButton.run(SKAction.fadeOut(withDuration: 0.5))
        difficultyLabel.run(SKAction.fadeOut(withDuration: 0.5))
        
        settingsTapped = false
        
        presentRandomNotificaiton()
        
        
    }
    
    func openInfo(){
        
        InfoTapped = true
        
        infoButton.setScale(0.35)
        
        
        label3.run(SKAction.moveTo(y: lane1.getPos().y - self.frame.width/22, duration: 0.5))
        label1.run(SKAction.moveTo(y: lane1.getPos().y, duration: 0.5))
        
        
        moneyButton.zPosition = 3
        settingButton.zPosition = 3
        questionButton.zPosition = 3
        
        label5.run(SKAction.fadeIn(withDuration: 0.5))
        label6.run(SKAction.fadeIn(withDuration: 0.5))
        
        facebookButton.run(SKAction.fadeIn(withDuration: 0.5))
        emailButton.run(SKAction.fadeIn(withDuration: 0.5))
        twitterButton.run(SKAction.fadeIn(withDuration: 0.5))
        
        versionLabel.alpha = 0.5
        
        
        easyButton.run(SKAction.fadeOut(withDuration: 0.5))
        mediumButton.run(SKAction.fadeOut(withDuration: 0.5))
        hardButton.run(SKAction.fadeOut(withDuration: 0.5))
        difficultyLabel.run(SKAction.fadeOut(withDuration: 0.5))
        
    }
    
    func closeInfo(){
        
        infoButton.setScale(0.35)
        
        
        label3.run(SKAction.moveTo(y: lane2.getPos().y - self.frame.width/22, duration: 0.5))
        label1.run(SKAction.moveTo(y: lane2.getPos().y, duration: 0.5))
        
        //show information about the game
        
        
        label5.run(SKAction.fadeOut(withDuration: 0.5))
        label6.run(SKAction.fadeOut(withDuration: 0.5))
        
        facebookButton.run(SKAction.fadeOut(withDuration: 0.5))
        emailButton.run(SKAction.fadeOut(withDuration: 0.5))
        twitterButton.run(SKAction.fadeOut(withDuration: 0.5))
        
        versionLabel.run(SKAction.fadeOut(withDuration: 0.5))
        
        
        moneyButton.zPosition = 12
        settingButton.zPosition = 12
        questionButton.zPosition = 12
        
        easyButton.run(SKAction.fadeIn(withDuration: 0.5))
        mediumButton.run(SKAction.fadeIn(withDuration: 0.5))
        hardButton.run(SKAction.fadeIn(withDuration: 0.5))
        difficultyLabel.run(SKAction.fadeIn(withDuration: 0.5))
        
        
        InfoTapped = false
        
    }
    
    func openMoney(){
        
        MoneyTapped = true
        
        moneyButton.setScale(0.35)
        
        if Scenario.yoelCamp {
            if Scenario.allwaysSpeeding == false {
                Scenario.allwaysSpeeding = true
            }else{
                Scenario.allwaysSpeeding = false
                Scenario.yoelCamp = false
            }
        }
        
        label3.run(SKAction.moveTo(y: lane1.getPos().y - self.frame.width/22, duration: 0.5))
        label1.run(SKAction.moveTo(y: lane1.getPos().y, duration: 0.5))
        
        
        
        //open tap 1
        //open tap 2
        // open tap 3
        
        label22.run(SKAction.fadeIn(withDuration: 0.5))
        label23.run(SKAction.fadeIn(withDuration: 0.5))
        label24.run(SKAction.fadeIn(withDuration: 0.5))
        
        
        infoButton.zPosition = 3
        settingButton.zPosition = 3
        questionButton.zPosition = 3
        
        
        easyButton.run(SKAction.fadeOut(withDuration: 0.5))
        mediumButton.run(SKAction.fadeOut(withDuration: 0.5))
        hardButton.run(SKAction.fadeOut(withDuration: 0.5))
        difficultyLabel.run(SKAction.fadeOut(withDuration: 0.5))
        
    }
    
    func closeMoney(){
        
        moneyButton.setScale(0.35)
        
        
        label3.run(SKAction.moveTo(y: lane2.getPos().y - self.frame.width/22, duration: 0.5))
        label1.run(SKAction.moveTo(y: lane2.getPos().y, duration: 0.5))
        
        //show information about the game
        
        
        label22.run(SKAction.fadeOut(withDuration: 0.5))
        label23.run(SKAction.fadeOut(withDuration: 0.5))
        label24.run(SKAction.fadeOut(withDuration: 0.5))
        
        
        
        infoButton.zPosition = 12
        settingButton.zPosition = 12
        questionButton.zPosition = 12
        
        
        easyButton.run(SKAction.fadeIn(withDuration: 0.5))
        mediumButton.run(SKAction.fadeIn(withDuration: 0.5))
        hardButton.run(SKAction.fadeIn(withDuration: 0.5))
        difficultyLabel.run(SKAction.fadeIn(withDuration: 0.5))
        
        MoneyTapped = false
        
    }
    
    func openGameCenter(){
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "uploadHighscore"), object: nil)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showLeaderboard"), object: nil)
    
        
//        questionsTapped = true
        
        questionButton.setScale(0.35)
        
        
//        label3.run(SKAction.moveTo(y: lane1.getPos().y - self.frame.width/22, duration: 0.5))
//        label1.run(SKAction.moveTo(y: lane1.getPos().y, duration: 0.5))
//        
//        //comingSoonLabel.alpha = 1
//        
//        
//        infoButton.zPosition = 3
//        settingButton.zPosition = 3
//        moneyButton.zPosition = 3
//        
//        easyButton.run(SKAction.fadeOut(withDuration: 0.5))
//        mediumButton.run(SKAction.fadeOut(withDuration: 0.5))
//        hardButton.run(SKAction.fadeOut(withDuration: 0.5))
//        difficultyLabel.run(SKAction.fadeOut(withDuration: 0.5))
        
    }
    
    func closeGameCenter(){
        
        questionButton.setScale(0.35)
        
        
        label3.run(SKAction.moveTo(y: lane2.getPos().y - self.frame.width/22, duration: 0.5))
        label1.run(SKAction.moveTo(y: lane2.getPos().y, duration: 0.5))
        
        //show information about the game
        
        //comingSoonLabel.alpha = 0
        
        
        infoButton.zPosition = 12
        settingButton.zPosition = 12
        moneyButton.zPosition = 12
        
        easyButton.run(SKAction.fadeIn(withDuration: 0.5))
        mediumButton.run(SKAction.fadeIn(withDuration: 0.5))
        hardButton.run(SKAction.fadeIn(withDuration: 0.5))
        difficultyLabel.run(SKAction.fadeIn(withDuration: 0.5))
        
        
        questionsTapped = false
        
    }
    
    
    func pauseUnPause(){
        
        
        self.pauseButton.alpha = 0
        self.playButton.alpha = 1
        self.exitRoundButton.alpha = 1
        self.settingsBackground.alpha = 0.85
        
        Scenario.globalButton1 = pauseButton
        Scenario.globalButton4 = settingButton
        
        self.isPaused = true
        
        
        
    }
    
    
    
    
    
    @objc func UnPause(){
        
        
        self.pauseButton.alpha = 1
        self.playButton.alpha = 0
        self.exitRoundButton.alpha = 0
        self.settingsBackground.alpha = 0
        
        
        
    }
    
    @objc func UnPauseEndRound(){
        
        
        UnPause()
        endRound()
        
        
    }
    
    
    
    
    
    
    
    
    
    
    func presentRandomNotificaiton(){
        
        let randomTemp = Int(arc4random_uniform(100))
        
        if randomTemp < 5 {
        
            if Scenario.inAlert == true {
                //cant make more than one alert
            }else{
            
                Scenario.inAlert = true
                
                alertCount += 1
                
                alert = CustomAlert(ImageNamed: "notification_\(Int(arc4random_uniform(3)) + 1)")
                
                addChild(alert)
                
                alert.run(SKAction.scale(to: 1, duration: 0.15))
            }
        
        }else{
            
        }
        
        
    }
    
    
    
    func touchDown(atPoint pos : CGPoint) {
        
        
        
        if(Scenario.inAlert == true){
            
            alertCount -= 1
            alert.alpha = 0
            
            if(alertCount == 0){
                Scenario.inAlert = false
            }else{
                
            }
            
            
        }else{
            
            if(demoPlaying == false){
            
                if(gameStarted == false){
                    
                    if(settingsTapped == true){
                        
                        
                        if(InfoTapped == true){
                            
                            let nodess = nodes(at: pos)
                            
                            for joe in nodess {
                                
                                
                                
                                if(joe.name == "MoneyButt"){
                                    
                                    closeInfo()
                                    openMoney()
                                    
                                }else if (joe.name == "Gamecenter-icon"){
                                    
                                    closeInfo()
                                    openGameCenter()
                                    
                                }else if (joe.name == "infoButt"){
                                    
                                    closeInfo()
                                    openSettings()
                                    
                                }else if (joe.name == "settings image"){
                                    
                                    closeInfo()
                                    openSettings()
                                    
                                }else{
                                    
                                    if(joe.name == "EmailButton"){
                                        //send email
                                        emailButton.setScale(0.35)
                                        
    //                                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showLeaderboard"), object: nil)
                                    
                                        
                                        
                                        let faceBookhooks = "mailto:samuelhoffmann.development%40gmail.com"
                                        let facebookURl = NSURL(string: faceBookhooks)
                                        if UIApplication.shared.canOpenURL(facebookURl! as URL)
                                        {
                                            UIApplication.shared.openURL(facebookURl! as URL)
                                            
                                        } else {
                                            //redirect to safari because the user doesn't have Instagram
                                            UIApplication.shared.openURL(NSURL(string: "mailto:samuelhoffmann.development%40gmail.com")! as URL)
                                        }
                                        
                                        
                                    }else if(joe.name == "facebookButton"){
                                        //open facebook
                                        facebookButton.setScale(0.35)
                                        //clearAppData()
                                        let faceBookhooks = "https://www.facebook.com/TicketTapApp"
                                        let facebookURl = NSURL(string: faceBookhooks)
                                        if UIApplication.shared.canOpenURL(facebookURl! as URL)
                                        {
                                            UIApplication.shared.openURL(facebookURl! as URL)
                                            
                                        } else {
                                            //redirect to safari because the user doesn't have Instagram
                                            UIApplication.shared.openURL(NSURL(string: "https://www.facebook.com/")! as URL)
                                        }
                                        
                                        
                                        
                                    }else if(joe.name == "twitterButton"){
                                        //open twitter
                                        twitterButton.setScale(0.35)
                                        
                                        let twitterhooks = "https://twitter.com/SamuelHHoffmann"
                                        let twitterURL = NSURL(string: twitterhooks)
                                        if UIApplication.shared.canOpenURL(twitterURL! as URL)
                                        {
                                            UIApplication.shared.openURL(twitterURL! as URL)
                                            
                                        } else {
                                            //redirect to safari because the user doesn't have Instagram
                                            UIApplication.shared.openURL(NSURL(string: "https://twitter.com/")! as URL)
                                        }
                                        
                                    }else{
                                        
                                    }
                                    
                                    
                                    
                                }
                            
                            }
                            
                            
                        }else if(MoneyTapped == true){
                            
                            let nodess = nodes(at: pos)
                            
                            for joe in nodess {
                                
                                
                                if(joe.name == "MoneyButt"){
                                    
                                    closeMoney()
                                    openSettings()
                                    
                                }else if (joe.name == "Gamecenter-icon"){
                                    
                                    closeMoney()
                                    openGameCenter()
                                    
                                }else if (joe.name == "infoButt"){
                                    
                                    closeMoney()
                                    openInfo()
                                    
                                }else if (joe.name == "settings image"){
                                    
                                    closeMoney()
                                    openSettings()
                                    
                                }else{
                                    
                                }
                                
                            }
                            
                            
                        }else if(questionsTapped == true){
                            
                            
                            let nodess = nodes(at: pos)
                            
                            for joe in nodess {
                                
                                
                                if(joe.name == "MoneyButt"){
                                    
                                    closeGameCenter()
                                    openMoney()
                                    
                                }else if (joe.name == "Gamecenter-icon"){
                                    
                                    closeGameCenter()
                                    openSettings()
                                    
                                }else if (joe.name == "infoButt"){
                                    
                                    closeGameCenter()
                                    openInfo()
                                    
                                }else if (joe.name == "settings image"){
                                    
                                    closeGameCenter()
                                    openSettings()
                                    
                                }else{
                                    
                                }
                                
                                
                                
                            }
                            
                            
                            
                        }else{ //no sub tabs are open
                        
                        
                            let nodess = nodes(at: pos)
                            
                            for joe in nodess {
                                
                                
                                if(joe.name == "settings image"){
                                    
                                    closeSettings()
                                    
                                    
                                }else if(joe.name == "infoButt"){
                                    
                                    openInfo()
                                    
                                    
                                }else if(joe.name == "MoneyButt"){
                                    
                                    openMoney()
                                    
                                    
                                }else if(joe.name == "Gamecenter-icon"){
                                    
                                    
                                    openGameCenter()
                                    
                                    
                                }else{
                                    
                                    if(joe.name == "EasyButton"){
                                        
                                        easyButton.setScale(0.35)
                                        difficulty = 0
                                        setDifficulty()
                                        updateHighscore(afterRound: false, ingoreOne: false)
                                        
                                    }else if(joe.name == "MediumButton"){
                                        
                                        mediumButton.setScale(0.35)
                                        difficulty = 1
                                        setDifficulty()
                                        updateHighscore(afterRound: false, ingoreOne: false)
                                        
                                    }else if(joe.name == "HardButton"){
                                        
                                        
                                        hardButton.setScale(0.35)
                                        difficulty = 2
                                        setDifficulty()
                                        updateHighscore(afterRound: false, ingoreOne: false)
                                        
                                    }else{
                                        
                                    }
                                    
                                    
                                    
                                }
                                
                            }
                            
                            
                        }
                        
                        
                        
                    }else{
                    
                        if(mainSubOpen == false){
                        
                        //let nodess = nodes(at: pos)
                        
                        var nodeClicked = false
                        
                            
                        
                                if((pos.x >= settingButton.position.x-settingButton.size.width && pos.x <= settingButton.position.x+settingButton.size.width) && (pos.y >= settingButton.position.y-settingButton.size.height && pos.y <= settingButton.position.y+settingButton.size.height)){
                                    
                                    
                                    openSettings()
                                    nodeClicked = true
                                    
                                    //open settings screen
                                    
                                }else if((pos.x >= speedLimitSprite.position.x-speedLimitSprite.size.width && pos.x <= speedLimitSprite.position.x+speedLimitSprite.size.width) && (pos.y >= speedLimitSprite.position.y-speedLimitSprite.size.height && pos.y <= speedLimitSprite.position.y+speedLimitSprite.size.height)){
                                
                                    //TODO: open sub menu for speed limit
                                    nodeClicked = true
                                    mainSubOpen = true
                                    settingsBackground.alpha = 0.85
                                    label1.run(SKAction.fadeOut(withDuration: 0.5))
                                    label2.run(SKAction.fadeOut(withDuration: 0.5))
                                    label3.run(SKAction.fadeOut(withDuration: 0.5))
                                    
                                    label17.run(SKAction.fadeIn(withDuration: 0.5))
                                    label18.run(SKAction.fadeIn(withDuration: 0.5))
                                    label19.run(SKAction.fadeIn(withDuration: 0.5))
                                    
                                    speedLimitLabel.zPosition = 13
                                    speedLimitLabel.position = label17.position
                                    speedLimitLabel.position.y = lane2.getPos().y
                                    speedLimitLabel.fontSize = 180
                                    
                                    speedLimitSprite.run(SKAction.fadeOut(withDuration: 0.5))
                                    ticketsSprite.run(SKAction.fadeOut(withDuration: 0.5))

                                    
                                    
                                    
                                    
                                    
                                    
                                }else if((pos.x >= ticketsSprite.position.x-ticketsSprite.size.width && pos.x <= ticketsSprite.position.x+ticketsSprite.size.width) && (pos.y >= ticketsSprite.position.y-ticketsSprite.size.height && pos.y <= ticketsSprite.position.y+ticketsSprite.size.height)){
                                    
                                    //TODO: open tickets sub menu
                                    nodeClicked = true
                                    mainSubOpen = true
                                    settingsBackground.alpha = 0.85
                                    label1.run(SKAction.fadeOut(withDuration: 0.5))
                                    label2.run(SKAction.fadeOut(withDuration: 0.5))
                                    label3.run(SKAction.fadeOut(withDuration: 0.5))
                                    
                                    label16.run(SKAction.fadeIn(withDuration: 0.5))
                                    label20.run(SKAction.fadeIn(withDuration: 0.5))
                                    label21.run(SKAction.fadeIn(withDuration: 0.5))
                                    
                                    ticketsLimit.zPosition = 13
                                    ticketsLimit.position = label16.position
                                    ticketsLimit.position.y = lane2.getPos().y
                                    ticketsLimit.fontSize = 180
                                    
                                    ticketsSprite.run(SKAction.fadeOut(withDuration: 0.5))
                                    speedLimitSprite.run(SKAction.fadeOut(withDuration: 0.5))
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                }else if((pos.x >= highscoreNode.position.x-highscoreNode.size.width && pos.x <= highscoreNode.position.x+highscoreNode.size.width) && (pos.y >= highscoreNode.position.y-highscoreNode.size.height && pos.y <= highscoreNode.position.y+highscoreNode.size.height)){
                                    
                                    nodeClicked = true
                                    mainSubOpen = true
                                    settingsBackground.alpha = 0.85
                                    label13.position = CGPoint(x: 0, y: lane2.getPos().y)
                                    label13.alpha = 1
                                    
                                    label1.run(SKAction.fadeOut(withDuration: 0.5))
                                    label2.run(SKAction.fadeOut(withDuration: 0.5))
                                    label3.run(SKAction.fadeOut(withDuration: 0.5))
                                    
                                    label15.run(SKAction.fadeIn(withDuration: 0.5))
                                    
                                    highscoreNodeLabel.zPosition = 13
                                    highscoreNodeLabel.position = label15.position
                                    highscoreNodeLabel.position.y = lane4.getPos().y
                                    highscoreNodeLabel.fontSize = 180
                                    highscoreNode.run(SKAction.fadeOut(withDuration: 0.5))
                                    
                                    easyButton.run(SKAction.fadeIn(withDuration: 0.5))
                                    mediumButton.run(SKAction.fadeIn(withDuration: 0.5))
                                    hardButton.run(SKAction.fadeIn(withDuration: 0.5))
                                    difficultyLabel.run(SKAction.fadeIn(withDuration: 0.5))
                                    
                                    
                                }else{
                                    
                                    //stop music
                                    
                                    //get rid of titles
                                    

                                    self.label1.run(SKAction.fadeOut(withDuration: 1.5))
                                    self.label2.run(SKAction.fadeOut(withDuration: 1.5))
                                    self.label3.run(SKAction.fadeOut(withDuration: 1.5))
                                    self.settingButton.run(SKAction.fadeOut(withDuration: 1.5))
                                    
                                    self.removeAllActions()
                                    
                                    self.delayTime = 4
                                    
                                    self.penalties = 0
                                    self.tickets = 0
                                    self.ticketsLimit.text = "\(self.tickets)"
                                    
                                    
                                    self.highscoreNode.run(SKAction.fadeOut(withDuration: 1.5))
                                    self.highscoreNodeLabel.run(SKAction.fadeOut(withDuration: 1.5))
                        
                                    label4.run(SKAction.fadeIn(withDuration: 0.5))
                                    
                                    
                                    
                                    gameStarted = true
                                    
                                    
                                    if(difficulty == 3){
                                        sendCar(speed: Int(arc4random_uniform(2)), forever: false, police: true, demo: false)
                                    }else{
                                        sendCar(speed: Int(difficulty), forever: false, police: true, demo: false)
                                    }
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    //set up speed limit
                                    
                                    //show example
                                    
                                    //3,2,1?
                                    
                                    // start speeding up loop
                                    
                                    
                                    
                                }
                            
                        
                        
                            if(nodeClicked == false){
                                
                                self.label1.run(SKAction.fadeOut(withDuration: 1.5))
                                self.label2.run(SKAction.fadeOut(withDuration: 1.5))
                                self.label3.run(SKAction.fadeOut(withDuration: 1.5))
                                self.settingButton.run(SKAction.fadeOut(withDuration: 1.5))
                                
                                self.removeAllActions()
                                
                                self.delayTime = 5
                                
                                self.penalties = 0
                                self.tickets = 0
                                self.ticketsLimit.text = "\(self.tickets)"
                                
                                
                                self.highscoreNode.run(SKAction.fadeOut(withDuration: 1.5))
                                self.highscoreNodeLabel.run(SKAction.fadeOut(withDuration: 1.5))
                        
                                label4.run(SKAction.fadeIn(withDuration: 0.5))
                                
                                
                                gameStarted = true
                                
                                if(difficulty == 3){
                                    sendCar(speed: Int(arc4random_uniform(2)), forever: false, police: true, demo: false)
                                }else{
                                    sendCar(speed: Int(difficulty), forever: false, police: true, demo: false)
                                }
                            }
                        
                        
                        }else{
                            //somthing is open
                            
                            //close it
                            let nodess = nodes(at: pos)
                            
                            var buttonTapped = false
                            
                            for joe in nodess {
                                
                                if(joe.name == "EasyButton"){
                                    
                                    easyButton.setScale(0.35)
                                    difficulty = 0
                                    setDifficulty()
                                    updateHighscore(afterRound: false, ingoreOne: true)
                                    buttonTapped = true
                                    
                                }else if(joe.name == "MediumButton"){
                                    
                                    mediumButton.setScale(0.35)
                                    difficulty = 1
                                    setDifficulty()
                                    updateHighscore(afterRound: false, ingoreOne: true)
                                    buttonTapped = true
                                    
                                }else if(joe.name == "HardButton"){
                                    
                                    hardButton.setScale(0.35)
                                    difficulty = 2
                                    setDifficulty()
                                    updateHighscore(afterRound: false, ingoreOne: true)
                                    buttonTapped = true
                                    
                                }else{
                                    
                                    
                                }
                                
                                if(buttonTapped == false){
                                    
                                    //close everything
                                    mainSubOpen = false
                                    settingsBackground.alpha = 0
                                    label13.alpha = 0
                                    
                                    label1.run(SKAction.fadeIn(withDuration: 0.5))
                                    label2.run(SKAction.fadeIn(withDuration: 0.5))
                                    label3.run(SKAction.fadeIn(withDuration: 0.5))
                                    
                                    label15.run(SKAction.fadeOut(withDuration: 0.5))
                                    label16.run(SKAction.fadeOut(withDuration: 0.5))
                                    label17.run(SKAction.fadeOut(withDuration: 0.5))
                                    label18.run(SKAction.fadeOut(withDuration: 0.5))
                                    label19.run(SKAction.fadeOut(withDuration: 0.5))
                                    label20.run(SKAction.fadeOut(withDuration: 0.5))
                                    label21.run(SKAction.fadeOut(withDuration: 0.5))
                                    
                                    
                                    
                                    
                                    
                                    ticketsLimit.fontSize = 75
                                    ticketsLimit.position = CGPoint(x: -self.frame.height/6 - self.frame.height/22, y: self.frame.width/6 + self.frame.width/32)
                                    ticketsLimit.zPosition = 4
                                    
                                    speedLimitLabel.fontSize = 75
                                    speedLimitLabel.position = CGPoint(x: -self.frame.height/6 - self.frame.height/12, y: self.frame.width/6 + self.frame.width/32)
                                    speedLimitLabel.zPosition = 4
                                    
                                    highscoreNodeLabel.fontSize = 75
                                    highscoreNodeLabel.position = CGPoint(x: -self.frame.height/6 - self.frame.height/12, y: -self.frame.width/6 - self.frame.width/16 - self.frame.width/40)
                                    highscoreNodeLabel.zPosition = 4
                                    
                                    
                                    
                                    ticketsSprite.run(SKAction.fadeIn(withDuration: 0.5))
                                    speedLimitSprite.run(SKAction.fadeIn(withDuration: 0.5))
                                    
                                    updateHighscore(afterRound: false, ingoreOne: false)
                                    
                                    easyButton.run(SKAction.fadeOut(withDuration: 0.5))
                                    mediumButton.run(SKAction.fadeOut(withDuration: 0.5))
                                    hardButton.run(SKAction.fadeOut(withDuration: 0.5))
                                    difficultyLabel.run(SKAction.fadeOut(withDuration: 0.5))

                                    
                                }
                                
                                
                            }
                            
                            
                            
                        }
                        
                    }
                    
                    
                    
                }else{
                    
                    //check if its on a car or not
                    
                    if((pos.x >= pauseButton.position.x-pauseButton.size.width && pos.x <= pauseButton.position.x+pauseButton.size.width) && (pos.y >= pauseButton.position.y-pauseButton.size.height && pos.y <= pauseButton.position.y+pauseButton.size.height)){
                        pauseUnPause()
                    }else{
                    
                        if isPaused == true {
                            
                        }else{
                            let nodess = nodes(at: pos)
                            
                            for joe in nodess {
                                
                                if joe.name == "Speeding" {
                                    let bob = joe as? Car
                                    bob?.lane.removerCar()
                                    
                                    joe.removeFromParent()
                                    tickets += 1
                                    ticketsLimit.text = "\(tickets)"
                                    
                                }else if joe.name == "notSpeeding"{
                                    
                                    let bob = joe as? Car
                                    bob?.lane.removerCar()
                                    
                                    joe.removeFromParent()
                                    penalties += 1
                                    updatePenalties()
                                    
                                    if(penalties > 3){
                                        
                                        
                                        endRound()
                                        
                                    }
                                }else{
                                    
                                    
                                    
                                }
                                
                                
                                
                            }
                        }
                        
                        
                    }
                    
                }
            
            }else{
                
                //show demo in progress label
                

                self.removeAllActions()
                
                if(self.demoPart == 1){
                    self.run(SKAction.sequence([part2, delay, delay, delay, part3, delay, delay, delay, part4, delay, delay]))
                }else if(self.demoPart == 2){
                    self.run(SKAction.sequence([part3, delay, delay, delay, part4, delay, delay]))
                }else if(self.demoPart == 3){
                    self.run(SKAction.sequence([part4, delay, delay]))
                }else{
                    
                }
                
                
                
                
    //            let block1 = SKAction.run {
    //                self.label12.run(SKAction.fadeIn(withDuration: 0.5))
    //            }
    //            
    //            let block2 = SKAction.run {
    //                self.label12.run(SKAction.fadeOut(withDuration: 0.5))
    //            }
    //            
    //            self.run(SKAction.sequence([block1, SKAction.wait(forDuration: 0.5), block2]))
                
                
            }
        }
    }
    
    
    
    func sendCar(speed: Int, forever: Bool, police: Bool, demo: Bool){
        
        
        
        self.carAmount = 0
        
        if(demo == true){
            self.delayTime = 5
        }else{
            self.delayTime = 4
        }
        
        var spawn = SKAction()
        
        spawn = SKAction.run({
            () in
            
            
            
            
            
            if(self.carAmount == 7){
                
                if(demo == false){
                    
                    if(self.delayTime > 1){
                        self.delayTime -= 1
                    }else{
                        
                    }
                    
                }
                
                self.removeAction(forKey: "spawnDelayForever")
                self.carAmount = 0
                
                let delay = SKAction.wait(forDuration: TimeInterval(self.delayTime))
                
                let spawnDelay = SKAction.sequence([spawn, delay])
                
                if(forever == true){
                    
                    let spawnDelayForever = SKAction.repeat(spawnDelay, count: 8)
                    
                    self.run(spawnDelayForever)
                    
                }else{
                    
                    self.run(spawnDelay)
                }
                
                
            }else{
                
                self.makeCar(police: police, demo: demo, speed: speed)
                
                self.carAmount += 1
                
                print("\(self.carAmount)")
                
                
            }
            
        })
        
        let delay = SKAction.wait(forDuration: TimeInterval(self.delayTime))
        
        let spawnDelay = SKAction.sequence([spawn, delay])
        
        if(forever == true){
            
            let spawnDelayForever = SKAction.repeat(spawnDelay, count: 11)
            
            self.run(spawnDelayForever)
            
        }else{
            self.run(spawnDelay)
        }
        
        if police == true || demo == true {
            
            let randomSpeedLimit = Int(arc4random_uniform(3)) + 1
            
            speedlimit = (randomSpeedLimit * 5) + 40
            speedLimitLabel.text = "\(speedlimit)"
            
        }
        
        if(speed == 0){
            
            
        }else if(speed == 1){
            
            
        }else if(speed == 2){
            
            
        }else{
            //unreachable code
        }
        
        
        
        
    }
    
    func makeCar(police: Bool, demo: Bool, speed: Int){
        
        var policeMutable = police
        
        //randomly send police cars
        if(policeMutable == false){
            let random = Int(arc4random_uniform(100))
            if random > 95 {
                policeMutable = true
            }
        }
        
        
        car = Car(Police: policeMutable)
        
        
        
        if(policeMutable == true){
            
            
            car.name = "police"
            
            
            
            lane2.addCar(carInstance: self.car)
            car.lane = lane2
            
            car.zRotation = CGFloat(Double.pi)
            car.normal = true
            
            //speed limit impulse
            
            let distance = CGFloat(self.frame.height/2 + self.frame.height/10 + 100)
            
            var moveCarLeft = SKAction()
            var movePipesRight = SKAction()
            
            car.setCarSpeed(speed1: self.speedlimit)
            
            moveCarLeft = SKAction.moveBy(x: -distance, y: 0, duration: TimeInterval((0.009 - (0.0001 * Double(self.speedlimit))) * Double(distance)))
            
            movePipesRight = SKAction.moveBy(x: distance, y: 0, duration: TimeInterval((0.009 - (0.0001 * Double(self.speedlimit))) * Double(distance)))
            
            
            
            let removePipes = SKAction.run({
                () in
                
                //print("car removed")
                //print(self.car.name)
                
                self.carRemoved = true
                self.label4.alpha = 0  //work request: make fade
                
                
                //work request: add code for next part of demo
                
                if police == false {
                    
                }else{
                    self.demoHandler()
                }
                
                
                
                self.lane2.removerCar()
                self.car.stopSound()
                self.removeFromParent()
                
            })
            
            
            moveAndRemoveLeft = SKAction.sequence([moveCarLeft, removePipes])
            moveAndRemoveRight = SKAction.sequence([movePipesRight, removePipes])

            
            car.run(moveAndRemoveLeft)
            
            
        }else{
            
            let distance = CGFloat(self.frame.height/2 + self.frame.height/10 + 100)
            
            var movePipesLeft = SKAction()
            var movePipesRight = SKAction()
            
            var speedLimitLimit = 65
            
            let number = getNumber()
            
            print("Lane \(number):")
            
            speedLimitLimit = lanes[number-1].getMaxSpeed()
            car.lane = lanes[number-1]
           
            print("max speed: \(speedLimitLimit)")
            
            var randomSpeed = 0.0 //= Double(arc4random_uniform(65)+15) //difficulty
            
            randomSpeed = Double(getSpeed(max: speedLimitLimit, difficulty: speed))
            
            if randomSpeed < 20 {
                randomSpeed = 20
            }
            
            print("using \(randomSpeed) as speed")
            
            car.setCarSpeed(speed1: Int(randomSpeed))
            
            
            
            
            if(demo == true){
                
                speedlimit = Int(randomSpeed)
                speedLimitLabel.text = "\(speedlimit)"
                
            }
            
            var speeding = false
            
            
            if(randomSpeed > Double(self.speedlimit)){
                car.name = "Speeding"
                speeding = true
            }else{
                car.name = "notSpeeding"
                speeding = false
                
                if demo == false {
                    if Scenario.yoelCamp {
                        if Scenario.allwaysSpeeding {
                            car.name = "Speeding"
                            speeding = true
                        }
                    }
                }
                
            }
            
            
            //print(randomSpeed)
            
            movePipesLeft = SKAction.moveBy(x: -distance, y: 0, duration: TimeInterval((0.009 - (0.0001 * Double(randomSpeed))) * Double(distance)))
            
            movePipesRight = SKAction.moveBy(x: distance, y: 0, duration: TimeInterval((0.009 - (0.0001 * Double(randomSpeed))) * Double(distance)))
            
            
            
            let removePipes = SKAction.run({
                () in
                
                //print("car removed")
                
                if(speeding == true){
                    
                    //print("speeding")
                    
                    self.penalties += 1
                    self.updatePenalties()
                    
                    if(self.penalties > 3){
                        
                        self.endRound()
                        
                    }
                }else{
                    
                }
                
                self.lanes[number-1].removerCar()
                
                
                
                self.car.stopSound()
                self.removeFromParent()
                
            })
            
            
            moveAndRemoveLeft = SKAction.sequence([movePipesLeft, removePipes])
            moveAndRemoveRight = SKAction.sequence([movePipesRight, removePipes])

            
            
            
            if(number == 1){
                
                lane1.addCar(carInstance: self.car)
                car.run(moveAndRemoveLeft)
            }else if(number == 2){
                
                lane2.addCar(carInstance: self.car)
                car.run(moveAndRemoveLeft)
            }else if(number == 3){
                
                lane3.addCar(carInstance: self.car)
                car.run(moveAndRemoveRight)
            }else{
                
                lane4.addCar(carInstance: self.car)
                car.run(moveAndRemoveRight)
            }
            
            
            
            

            //getLane(laneNumber: getNumber())
            
            
            //random inpulse
            
            
        }
        
        
        
        self.addChild(car)
        
        
    }
    
    func getSpeed(max: Int, difficulty: Int) -> Int {
        
        if(max <= 10){
            return 10
        }
        var random = Int(arc4random_uniform(30)) //number between 0 and 30
        
        print("speed limit is \(speedlimit)")
        
        random += Int(speedlimit - 15) //  speedlimit -15 < random < speedlimit +15
        
        if random > max {
            random = max - 5
        }
        
        print("does \(random) work?")
        
        if(difficulty == 0){
            if ((random % 10) == 0 ){
                return Int(random)
            }else{
                return getSpeed(max: max, difficulty: difficulty, current: Int(random) + 1)
            }
        }else if(difficulty == 1){
            if ((random % 5) == 0 ){
                return Int(random)
            }else{
                return getSpeed(max: max, difficulty: difficulty, current: Int(random) + 1)
            }
        }else if(difficulty == 2){
            if ((random % 1) == 0 ){
                return Int(random)
            }else{
                return getSpeed(max: max, difficulty: difficulty, current: Int(random) + 1)
            }
        }else{
            return Int(random)
        }
        
    }
    
    
    func getSpeed(max: Int, difficulty: Int, current: Int) -> Int {
        
        
        if(difficulty == 0){
            if ((current % 10) == 0 ){
                return current
            }else{
                return getSpeed(max: max, difficulty: difficulty, current: current + 1)
            }
        }else if(difficulty == 1){
            if ((current % 5) == 0 ){
                return current
            }else{
                return getSpeed(max: max, difficulty: difficulty, current: current + 1)
            }
        }else if(difficulty == 2){
            if ((current % 1) == 0 ){
                return current
            }else{
                return getSpeed(max: max, difficulty: difficulty, current: current + 1)
            }
        }else{
            return current
        }
        
    }
    
    
    
    
    
    func endRound(){
        
        self.removeAllActions()
//
//        for tempLane in lanes {
//            if tempLane.isEmpty() == false {
//                for bob in tempLane.cars {
//                    tempLane.removerCar()
//                    bob.removeAllActions()
//                    bob.removeFromParent()
//                }
//            }
//        }
        
        self.label1.alpha = 1
        self.label2.alpha = 1
        self.label3.alpha = 1
        self.settingButton.alpha = 1
        self.highscoreNode.alpha = 1
        self.highscoreNodeLabel.alpha = 1
        
        self.pauseButton.alpha = 0
        
        self.updateHighscore(afterRound: true, ingoreOne: false)
        //self.updatePenalties()
        
        self.gameStarted = false
        
        Scenario.yoelCamp = false
        
        
        //show score
        
        if(self.difficulty == 3){
            self.sendCar(speed: Int(arc4random_uniform(3)), forever: true, police: false, demo: true)
        }else{
            self.sendCar(speed: Int(self.difficulty), forever: true, police: false, demo: true)
        }

    }
    
    func demoHandler(){
        //current point
        
        self.label4.alpha = 0
        
        if(UserDefaults.standard.bool(forKey: "notFirstTime") == true){
            //start game forever
            
            pauseButton.run(SKAction.fadeIn(withDuration: 0.5))
            
            if(self.difficulty == 3){
                self.sendCar(speed: Int(arc4random_uniform(2)), forever: true, police: false, demo: false)
            }else{
                self.sendCar(speed: Int(self.difficulty), forever: true, police: false, demo: false)
            }
            
            
            
        }else{
            //give more explanations
            //demo in progress variable to check for in tapped method
            
            delay = SKAction.wait(forDuration: 2.5)
            
            part1 = SKAction.run {
                
                self.demoPart = 1
                
                self.demoPlaying = true
                
                self.settingsBackground.alpha = 0.85
                
                self.label7.alpha = 1
                self.label7.position = CGPoint(x: 0, y: self.lane1.getPos().y)
                
                self.speedLimitLabel.zPosition = 13
                self.speedLimitSprite.zPosition = 12
                
            }
            
            part2 = SKAction.run {
                //remove part 1
                
                self.demoPart = 2
                
                self.label7.alpha = 0
                
                self.speedLimitLabel.zPosition = 4
                self.speedLimitSprite.zPosition = 3
                
                //show part 2
                
                self.label8.alpha = 1
                self.label8.position = CGPoint(x: 0, y: self.lane2.getPos().y)
                self.ticketsLimit.zPosition = 13
                self.ticketsSprite.zPosition = 12
                
                
            }
            
            
            part3 = SKAction.run {
                
                self.demoPart = 3
                
                self.label8.alpha = 0
                
                self.ticketsLimit.zPosition = 4
                self.ticketsSprite.zPosition = 3
                
                //show part 2
                
                self.label9.alpha = 1
                self.label10.alpha = 1
                
                self.penalties = 1
                self.updatePenalties()
                
                self.penalties = 2
                self.updatePenalties()
                
                self.penaltyDot1.zPosition = 12
                self.penaltyDot2.zPosition = 12
                
                self.label9.position = CGPoint(x: 0, y: self.lane2.getPos().y)
                self.label10.position = CGPoint(x: 0, y: self.lane3.getPos().y)
                
                
                
            }
            
            part4 = SKAction.run {
                
                self.demoPart = 0
                
                self.endRound()
                
                self.gameStarted = true
                
                self.label9.alpha = 0
                self.label10.alpha = 0
                
                self.penaltyDot1.zPosition = 3
                self.penaltyDot2.zPosition = 3
                
                //show last label
                
                self.settingButton.zPosition = 12
                
                self.label11.alpha = 1
                self.label11.position = CGPoint(x: 0, y: self.lane4.getPos().y)
                
                //self.run(SKAction.wait(forDuration: 5))
                
                self.penalties = 0
                self.updatePenalties()
                
                self.settingsBackground.run(SKAction.fadeOut(withDuration: 5))
                self.settingButton.zPosition = 3
                //self.label11.alpha = 0
                
                
                UserDefaults.standard.set(true, forKey: "notFirstTime")
                
                self.label11.run(SKAction.fadeOut(withDuration: 5))
                
                self.demoPlaying = false
                
                
                
                
                
            }
            
            
            
            self.run(SKAction.sequence([part1, delay, delay, delay, part2, delay, delay, delay, part3, delay, delay, delay, part4, delay, delay]))
            
            //then...
            
            
        }
        
        
        
    }
    
    
    
    
    
    func getNumber() -> Int{
        
        let number = (Int(arc4random_uniform(4)) + 1)
        
        
        
        
        if(number == 1){
            if(lane1.isEmpty() == true){
                return 1
            }else{
                if(lane2.isEmpty() == true){
                    return 2
                }else{
                    if(lane3.isEmpty() == true){
                        return 3
                    }else{
                        return 4
                    }
                }
            }
        }else if(number == 2){
            if(lane2.isEmpty() == true){
                return 2
            }else{
                if(lane3.isEmpty() == true){
                    return 3
                }else{
                    if(lane4.isEmpty() == true){
                        return 4
                    }else{
                        return 1
                    }
                }
            }
        }else if(number == 3){
            if(lane3.isEmpty() == true){
                return 3
            }else{
                if(lane4.isEmpty() == true){
                    return 4
                }else{
                    if(lane1.isEmpty() == true){
                        return 1
                    }else{
                        return 2
                    }
                }
            }
        }else{
            if(lane4.isEmpty() == true){
                return 4
            }else{
                if(lane1.isEmpty() == true){
                    return 1
                }else{
                    if(lane2.isEmpty() == true){
                        return 2
                    }else{
                        return 3
                    }
                }
            }
        }
        
        
    }
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
        settingButton.setScale(0.40)
        infoButton.setScale(0.40)
        moneyButton.setScale(0.40)
        questionButton.setScale(0.40)
        facebookButton.setScale(0.40)
        emailButton.setScale(0.40)
        twitterButton.setScale(0.40)
        easyButton.setScale(0.40)
        mediumButton.setScale(0.40)
        hardButton.setScale(0.40)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
//        for snowflake in snow {
//            
//            if (snowflake.position.y < 20 && snowflake.position.y > -20) {
//                
//                snowflake.removeFromParent()
//                
//            }
//            
//        }
        
        
    }
}



//                                code to pause a view, unsure how to unpause
//                                let pauseAction = SKAction.run {
//                                    self.view?.isPaused = true
//                                }
//                                self.run(pauseAction)
//
//

