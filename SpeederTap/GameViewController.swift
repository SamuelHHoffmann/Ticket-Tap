//
//  GameViewController.swift
//  SpeederTap
//
//  Created by Samuel Hoffmann on 12/8/16.
//  Copyright © 2016 Samuel Hoffmann. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import GameKit

class GameViewController: UIViewController, GKGameCenterControllerDelegate {
    
    
    @objc var globalScene = SKScene()
    @objc var firstPause = true

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authPlayer()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.showLeaderboard), name: NSNotification.Name(rawValue: "showLeaderboard"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.uploadHighscore), name: NSNotification.Name(rawValue: "uploadHighscore"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.pause), name: NSNotification.Name(rawValue: "pause"), object: nil)
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            view.sizeToFit()
            //view.safeAreaInsets
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                globalScene = scene
                
//                if self.view.frame.width == 812 && self.view.frame.height == 375.0 {
//                    //iphone 10
//
//                    globalScene.scaleMode = .aspectFit
//
//                }else{
//
//                }
                
                globalScene.scaleMode = .aspectFill
                
                
                
                //globalScene.sc
                
                // Present the scene
                view.presentScene(globalScene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
        }
        
        
        
        
    }

    
    @objc func authPlayer(){
        
        let player = GKLocalPlayer.localPlayer()
        
        player.authenticateHandler = {
            (view, error) in
            
            if view != nil {
                
                self.present(view!, animated: true, completion: nil)
                
            }else{
                print(GKLocalPlayer.localPlayer().isAuthenticated)
            }
            
            
        }
        
        
        
    }
    
    @objc func uploadHighscore(){
        
        if GKLocalPlayer.localPlayer().isAuthenticated {
            
            let easyScoreReporter = GKScore(leaderboardIdentifier: "Easy_Leaderboard")
            
            easyScoreReporter.value = Int64(UserDefaults.standard.integer(forKey: "Easyhighscore"))
            
            let easyScoreArray : [GKScore] = [easyScoreReporter]
            
            GKScore.report(easyScoreArray, withCompletionHandler: nil)
            
            
            let medScoreReporter = GKScore(leaderboardIdentifier: "Medium_Leaderboard")
            
            medScoreReporter.value = Int64(UserDefaults.standard.integer(forKey: "mediumHighscore"))
            
            let medScoreArray : [GKScore] = [medScoreReporter]
            
            GKScore.report(medScoreArray, withCompletionHandler: nil)
            
            
            let hardScoreReporter = GKScore(leaderboardIdentifier: "Hard_Leaderboard")
            
            hardScoreReporter.value = Int64(UserDefaults.standard.integer(forKey: "hardHighscore"))
            
            let hardScoreArray : [GKScore] = [hardScoreReporter]
            
            GKScore.report(hardScoreArray, withCompletionHandler: nil)
            
            
            
//            let extremeScoreReporter = GKScore(leaderboardIdentifier: "Extreme_Leaderboard")
//            
//            extremeScoreReporter.value = Int64(UserDefaults.standard.integer(forKey: "Extremehighscore"))
//            
//            let extremeScoreArray : [GKScore] = [extremeScoreReporter]
//            
//            GKScore.report(extremeScoreArray, withCompletionHandler: nil)
            
            
        }else{
            
            //prompt user to log into gamecenter
            
        }
        
        
    }
    
    
    @objc func showLeaderboard(){
        
        if GKLocalPlayer.localPlayer().isAuthenticated {
            let viewController = self.view.window?.rootViewController
            let gamecenterViewController = GKGameCenterViewController()
            
            gamecenterViewController.viewState = .leaderboards
            
            gamecenterViewController.gameCenterDelegate = self
            
            viewController?.present(gamecenterViewController, animated: true, completion: nil)
            
        }
//        else{
//            authPlayer()
//            showLeaderboard()
//        }
    }
    
    
    @objc func pause(){
        
        globalScene.isPaused = true
        
    }
    
    
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)

    }
    
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let pos = touches.first?.location(in: globalScene)
        
        if globalScene.isPaused == true{
            if firstPause == true{
                firstPause = false
            }else{
                
                if((pos!.x >= Scenario.globalButton1.position.x-Scenario.globalButton1.size.width && pos!.x <= Scenario.globalButton1.position.x+Scenario.globalButton1.size.width) && (pos!.y >= Scenario.globalButton1.position.y-Scenario.globalButton1.size.height && pos!.y <= Scenario.globalButton1.position.y+Scenario.globalButton1.size.height)){
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "play"), object: nil)
                    globalScene.isPaused = false
                    firstPause = true
                    
                }else if((pos!.x >= Scenario.globalButton4.position.x-Scenario.globalButton4.size.width && pos!.x <= Scenario.globalButton4.position.x+Scenario.globalButton4.size.width) && (pos!.y >= Scenario.globalButton4.position.y-Scenario.globalButton4.size.height && pos!.y <= Scenario.globalButton4.position.y+Scenario.globalButton4.size.height)){
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "endRound"), object: nil)
                    globalScene.isPaused = false
                    firstPause = true
                    
                }else{
                    
                }
                
                
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
