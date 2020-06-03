//
//  Extension+SpriteNode.swift
//  FightCovid19PlayGround
//
//  Created by Dedy Yuristiawan on 12/05/20.
//  Copyright © 2020 Dedy Yuristiawan. All rights reserved.
//

import SpriteKit

extension SKSpriteNode {
    
    // create func bounce, scale sprite node with duration
    func bounce() {
      let action2Duration = 0.3
      let action3Duration = 0.12
      let action4Duration = 0.2
      let action5Duration = 0.1
      let action2 = SKAction.scale(to: 1.2, duration: action2Duration)
      let action3 = SKAction.scale(to: 0.95, duration: action3Duration)
      let action4 = SKAction.scale(to: 1.1, duration: action4Duration)
      let action5 = SKAction.scale(to: 1.0, duration: action5Duration)
      let sequence = SKAction.sequence([action2, action3, action4, action5])
      self.run(sequence)
    }
    
}
