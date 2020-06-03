//
//  FightCovid19PlayGround
//
//  Created by Dedy Yuristiawan on 12/05/20.
//  Copyright © 2020 Dedy Yuristiawan. All rights reserved.
//

import PlaygroundSupport
import SpriteKit

// Load the SKScene from 'MainScene.sks'
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 896))
sceneView.showsFPS = true
sceneView.showsNodeCount = true
if let scene = MainScene(fileNamed: "MainScene") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFill
    // Present the scene
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
