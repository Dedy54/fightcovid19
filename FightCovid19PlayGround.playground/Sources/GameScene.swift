//
//  GameScene.swift
//  FightCovid19PlayGround
//
//  Created by Dedy Yuristiawan on 12/05/20.
//  Copyright © 2020 Dedy Yuristiawan. All rights reserved.
//

import SpriteKit

public class GameScene: SKScene {
    
    // create var item node
    var spriteVirusCovid19: SKSpriteNode!
    var peopleLabel:SKLabelNode!
    var heartLabel:SKLabelNode!
    var dayLabel:SKLabelNode!
    
    // get prev x position item emoji
    var previousTranslateX:CGFloat = 0.0
    
    var timer: Timer?
    var daysRemaining = 15
    var heartCount = 3
    
    // varibale to get contact, multiple collision to get just one collision
    var gotContact = false
    
    // emoji array available
    var stringEmoji : [String] = ["😀", "😘", "🤗", "😷", "🥰", "😋", "🤪", "🤓", "🥱", "🤧", "🤤", "🥳"]
    
    override public func didMove(to view: SKView) {
        self.setupView(view: view)
        self.makeDayLabel()
        self.makeHeartLabel()
        self.makeTimer()
        self.makeCovidNode()
        self.run(SKAction.repeatForever(SKAction.sequence([SKAction.run(self.makePeopleLabel), SKAction.run(self.makeCovidNode), SKAction.wait(forDuration: 2.0)])))
    }
    
    // setup ui change background to system background
    func setupView(view: SKView) {
        self.backgroundColor = UIColor.systemBackground
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        let uiPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(swipePanGestureRecognizer))
        view.addGestureRecognizer(uiPanGestureRecognizer)
    }
    
    // create node type label to show emoji, set attribute label, name, position,
    // set action move with random x pos, y bottom and add child
    func makePeopleLabel() {
        self.gotContact = false
        self.peopleLabel = SKLabelNode()
        self.peopleLabel.text = "🤤"
        if let randomElement = stringEmoji.randomElement() {
            self.peopleLabel.text = randomElement
        }
        self.peopleLabel.fontSize = 80
        self.peopleLabel.fontColor = UIColor.label
        
        self.peopleLabel.position = CGPoint(x: self.randomInRange(lo: Int(self.frame.minX + 200), hi: Int(self.frame.maxX - 200)), y: 0)
        self.peopleLabel.name = "people"
        
        self.peopleLabel.physicsBody = SKPhysicsBody(rectangleOf: peopleLabel.frame.size)
        self.peopleLabel.physicsBody?.categoryBitMask = 1
        self.peopleLabel.physicsBody?.contactTestBitMask = 1
        
        let movePeople = SKAction.moveTo(y: self.size.height, duration: 1.5)
        self.peopleLabel.run(movePeople)
        self.removeAllPeopleNode()
        self.addChild(self.peopleLabel)
    }
    
    // create node type spritenode to show virus covid, set attribute image, name, position,
    // set action move with random x pos, y bottom and add child
    func makeCovidNode() {
        let virusNodeYPosition = self.randomInRange(lo: Int(self.size.height/2 - 50), hi: Int(self.size.height/2 + 50))
        let virusNodeXPosition = self.randomInRange(lo: Int(self.size.width/2 - 50), hi: Int(self.size.width/2 + 50))
        
        self.spriteVirusCovid19 = SKSpriteNode(imageNamed: "covid19")
        self.spriteVirusCovid19.size =  CGSize(width: 50, height: 50)
        self.spriteVirusCovid19.position = CGPoint(x: virusNodeXPosition, y: virusNodeYPosition )
        self.spriteVirusCovid19.name = "covid"
        
        self.spriteVirusCovid19.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        self.spriteVirusCovid19.physicsBody?.categoryBitMask = 1
        self.spriteVirusCovid19.physicsBody?.contactTestBitMask = 1
        
        self.addChild(self.spriteVirusCovid19)
        self.spriteVirusCovid19.bounce()
    }
    
    // create node type label to show days, set attribute label, name, position,
    // default 14 days, cause covid - 19 can survive within 14days
    func makeDayLabel() {
        self.dayLabel = SKLabelNode()
        self.dayLabel.text = "14 Days"
        self.dayLabel.fontSize = 40
        self.dayLabel.position = CGPoint(x: 150, y: self.size.height - 100)
        self.dayLabel.fontColor = UIColor.label
        
        self.addChild(dayLabel)
    }
    
    // create node type label to show hearth emoji, set attribute label, name, position,
    // default 3 hearth days, to make game can endable.
    func makeHeartLabel() {
        self.heartLabel = SKLabelNode()
        self.heartLabel.text = "♥️♥️♥️"
        self.heartLabel.fontSize = 40
        self.heartLabel.position = CGPoint(x: self.size.width - 150, y: self.size.height - 100)
        self.heartLabel.fontColor = UIColor.label
        
        self.addChild(heartLabel)
    }
    
    // func make timer label day
    // show bounce when day label < 6
    // present to game over with win case
    func makeTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.daysRemaining > 0 {
                self.daysRemaining -= 1
                if self.daysRemaining < 6 {
                    self.dayLabel.bounce()
                }
                self.dayLabel.text = "\(self.daysRemaining) Days"
            } else {
                self.timer?.invalidate()
                self.presentGameOverScene(isWin: true)
            }
        }
    }
    
    // func to get random int between low int to hi int
    func randomInRange(lo: Int, hi : Int) -> Int {
        return lo + Int(arc4random_uniform(UInt32(hi - lo + 1)))
    }
    
    // func remove all child with type people
    // this is with use beofre we show people node
    func removeAllPeopleNode() {
        for child in self.children {
            if child.name == "people" {
                child.removeFromParent()
            }
        }
    }
    
    // present game over with parameter isWin within animate move right
    func presentGameOverScene(isWin: Bool) {
        if let gameOverScene = GameOverScene(fileNamed: "GameOverScene") {
            gameOverScene.isWin = isWin
            gameOverScene.scaleMode = .aspectFill
            let transition = SKTransition.moveIn(with: .right, duration: 1)
            self.scene?.view?.presentScene(gameOverScene, transition: transition)
        }
    }
    
    // func swipe pan gesture, to put emoji move to x position
    @objc func swipePanGestureRecognizer(sender: UIPanGestureRecognizer) {
        //retrieve pan movement along the x-axis of the view since the gesture began
        let currentTranslateX = sender.translation(in: view).x
        //calculate translation since last measurement
        let translateX = currentTranslateX - previousTranslateX
        //move shape within frame boundaries
        let newShapeX = peopleLabel.position.x + translateX
        if newShapeX < frame.maxX && newShapeX > frame.minX {
            peopleLabel.position = CGPoint(x: peopleLabel.position.x + translateX, y: peopleLabel.position.y)
        }
        //(re-)set previous measurement
        if sender.state == .ended {
            previousTranslateX = 0
        } else {
            previousTranslateX = currentTranslateX
        }
    }
    
}

extension GameScene : SKPhysicsContactDelegate {
    
    // func calculate when object get collision
    // call bounce when hearth decrease
    func getContactBody() {
        self.daysRemaining = 15
        self.heartCount -= 1
        
        switch self.heartCount {
        case 1:
            self.heartLabel.bounce()
            self.heartLabel.text = "♥️💔💔"
        case 2:
            self.heartLabel.bounce()
            self.heartLabel.text = "♥️♥️💔"
        case 3:
            self.heartLabel.bounce()
            self.heartLabel.text = "♥️♥️♥️"
        default:
            self.heartLabel.bounce()
            self.heartLabel.text = "💔💔💔"
            self.presentGameOverScene(isWin: false)
            return
        }
    }
    
    // use did begin contact to get collision
    // with condition same collisionBitMask and diferent name node
    // this is for collision between virus and emoji
    public func didBegin(_ contact: SKPhysicsContact) {
        if gotContact {return}
        
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        if bodyA.collisionBitMask == bodyB.collisionBitMask && bodyB.node?.name != bodyA.node?.name {
            self.getContactBody()
            self.gotContact = true
        }
    }
    
}
