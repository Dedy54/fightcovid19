//
//  GameOverScene.swift
//  FightCovid19PlayGround
//
//  Created by Dedy Yuristiawan on 12/05/20.
//  Copyright © 2020 Dedy Yuristiawan. All rights reserved.
//

import SpriteKit

public class GameOverScene: SKScene {
    
    // create var item node 
    var peopleLabel: SKLabelNode!
    var titleLabel: SKLabelNode!
    var playButton : SKSpriteNode!
    
    // variable winner for show diferent view lose and winner
    var isWin = false
    
    override public func didMove(to view: SKView) {
        self.setupUI(view: view)
        self.makePeopleLabel()
        self.makeTitleLabel()
        self.makePlayButton()
    }
    
    // setup ui change background to system background
    func setupUI(view: SKView) {
        self.backgroundColor = UIColor.systemBackground
    }
    
    // create node type label to show emoji, set attribute label, position, action
    func makePeopleLabel() {
        self.peopleLabel = SKLabelNode()
        self.peopleLabel.fontSize = 100
        self.peopleLabel.zPosition = 2
        self.peopleLabel.color = SKColor.white
        self.peopleLabel.horizontalAlignmentMode = .center
        self.peopleLabel.verticalAlignmentMode = .center
        if isWin {
            self.peopleLabel.text = "🥳"
            self.run(SKAction.repeatForever(SKAction.sequence([SKAction.run(self.makeBouchePeopleNode), SKAction.wait(forDuration: 2.0)])))
        } else {
            self.peopleLabel.text = "😷"
        }
        self.peopleLabel.fontColor = UIColor.label
        self.peopleLabel.position = CGPoint(x: self.size.width/2, y: self.size.height - 200)
        self.addChild(self.peopleLabel)
    }
    
    // create func bounce label people for call in action
    func makeBouchePeopleNode() {
        self.peopleLabel.bounce()
    }
    
    // create node type label to show title, set attribute label, position
    func makeTitleLabel() {
        self.titleLabel = SKLabelNode()
        self.titleLabel.fontSize = 30
        self.titleLabel.zPosition = 2
        self.titleLabel.color = SKColor.white
        self.titleLabel.horizontalAlignmentMode = .center
        self.titleLabel.verticalAlignmentMode = .center
        if isWin {
            self.titleLabel.text = "Hooray the pandemic is over, try again?"
        } else {
            self.titleLabel.text = "Keep wear a mask, try again?"
        }
        self.titleLabel.fontColor = UIColor.label
        self.titleLabel.position = CGPoint(x: self.size.width/2, y: self.size.height - 380)
        self.addChild(self.titleLabel)
    }
    
    // create node type spritenode to show button, set attribute like name, image, set position
    func makePlayButton() {
        self.playButton = SKSpriteNode(imageNamed: "replay")
        self.playButton.name = "playButton"
        self.playButton.size.height = 60
        self.playButton.size.width = 60
        self.playButton.position = CGPoint(x: self.size.width/2, y: self.size.height - 510)
        self.delayWithSeconds(1) {
            self.run(SKAction.repeatForever(SKAction.sequence([SKAction.run(self.makeBouchePlayButton), SKAction.wait(forDuration: 2.0)])))
        }
        self.addChild(self.playButton)
    }
    
    // delay func to call in play button condition after 1 second
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
    // create func bounce play button for call in action
    func makeBouchePlayButton() {
        self.playButton.bounce()
    }
    
    // detection play button to call action back present game scene
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let positionInScene = touch!.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name {
            if name == "playButton" {
                self.presentGameScene()
            }
        }
    }
    
    // present call game scene, and set the scale mode to scale to fit the window
    func presentGameScene() {
        if let scene = GameScene(fileNamed: "GameScene") {
            scene.scaleMode = .aspectFill
            let transition = SKTransition.moveIn(with: .left, duration: 1)
            self.scene?.view?.presentScene(scene, transition: transition)
        }
    }
    
}
