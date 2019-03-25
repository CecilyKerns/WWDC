//
//  GameScene.swift
//  ShibaInuGameShow
//
//  Created by Cecily Kerns on 2/20/19.
//  Copyright © 2019 Cecily Kerns. All rights reserved.
//

import SpriteKit

public class GameScene: SKScene {
    
    var backgroundAudioNode: SKAudioNode?    
    var backgroundMusicSound: Sound? {
        didSet {
            self.startBackgroundMusic()
        }
    }

    override public func sceneDidLoad() {
        self.backgroundColor = UIColor.clear
    }
    
    func startBackgroundMusic() {
        if let sound = self.backgroundMusicSound, let background = AudioPlayer.shared.play(sound: sound, on: self) {
            self.stopBackgroundMusic()
            self.backgroundAudioNode = background
            self.addChild(self.backgroundAudioNode!)
        }
    }
    
    func stopBackgroundMusic() {
        self.backgroundAudioNode?.removeFromParent()
    }
    
}
 
