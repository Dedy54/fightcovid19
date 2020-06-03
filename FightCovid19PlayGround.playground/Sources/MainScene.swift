//
//  MainScene.swift
//  FightCovid19PlayGround
//
//  Created by Dedy Yuristiawan on 12/05/20.
//  Copyright © 2020 Dedy Yuristiawan. All rights reserved.
//

import SpriteKit
import AVFoundation

public class MainScene: SKScene {
    
    // create var item for audio
    var backgroundSoundEffect: AVAudioPlayer?
    
    // create var item node
    var peopleLabel: SKLabelNode!
    var titleLabel: SKLabelNode!
    var subTitleLabel: SKLabelNode!
    var playButton : SKSpriteNode!
    
    override public func didMove(to view: SKView) {
        self.playBackgroundMusic()
        self.setupUI(view: view)
        self.makePeopleLabel()
        self.makeTitleLabel()
        self.makeSubTitleLabel()
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
        self.peopleLabel.text = "😷"
        self.peopleLabel.fontColor = UIColor.label
        self.peopleLabel.position = CGPoint(x: self.size.width/2, y: self.size.height - 200)
        self.peopleLabel.bounce()
        self.addChild(self.peopleLabel)
    }
    
    // create node type label to show title, set attribute label, position
    func makeTitleLabel() {
        self.titleLabel = SKLabelNode()
        self.titleLabel.fontSize = 48
        self.titleLabel.zPosition = 2
        self.titleLabel.color = SKColor.white
        self.titleLabel.horizontalAlignmentMode = .center
        self.titleLabel.verticalAlignmentMode = .center
        self.titleLabel.text = "Bye Bye Covid-19"
        self.titleLabel.fontColor = UIColor.label
        self.titleLabel.position = CGPoint(x: self.size.width/2, y: self.size.height - 350)
        self.addChild(self.titleLabel)
    }
    
    // create node type label to show sub title, set attribute label, position
    func makeSubTitleLabel() {
        self.subTitleLabel = SKLabelNode()
        self.subTitleLabel.fontSize = 28
        self.subTitleLabel.zPosition = 2
        self.subTitleLabel.color = SKColor.white
        self.subTitleLabel.horizontalAlignmentMode = .center
        self.subTitleLabel.verticalAlignmentMode = .center
        self.subTitleLabel.text = "Imagine world on your hands, save world now"
        self.subTitleLabel.fontColor = UIColor.label
        self.subTitleLabel.position = CGPoint(x: self.size.width/2, y: self.size.height - 400)
        self.addChild(self.subTitleLabel)
    }
    
    // create node type spritenode to show button, set attribute like name, image, set position
    func makePlayButton() {
        self.playButton = SKSpriteNode(imageNamed: "play")
        self.playButton.name = "playButton"
        self.playButton.size.height = 60
        self.playButton.size.width = 60
        self.playButton.position = CGPoint(x: self.size.width/2, y: self.size.height - 530)
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
    
    // show audio, find BackgroundMusic.mp3 get path, url and then try AVAudioPlayer with condition -1, loop music when ended.
    func playBackgroundMusic() {
        let path = Bundle.main.path(forResource: "BackgroundMusic.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            backgroundSoundEffect = try AVAudioPlayer(contentsOf: url)
            backgroundSoundEffect?.numberOfLoops = -1
            self.run(SKAction.playSoundFileNamed("BackgroundMusic.mp3", waitForCompletion: false))
        } catch {
            // can not find file
        }
    }
    
    // detection play button to call action present game scene
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
            let transition = SKTransition.moveIn(with: .right, duration: 1)
            self.scene?.view?.presentScene(scene, transition: transition)
        }
        
    }
    
}
