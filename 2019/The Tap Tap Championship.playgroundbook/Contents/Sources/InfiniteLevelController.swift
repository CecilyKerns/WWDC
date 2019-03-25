//
//  InfiniteLevelController.swift
//  ShibaInuGameShow
//
//  Created by Cecily Kerns on 3/15/19.
//  Copyright © 2019 Cecily Kerns. All rights reserved.
//

import UIKit

public class InfiniteLevelController: LevelMasterViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.backgroundImageView.image = UIImage(named: "Playground.Icon")
        self.backgroundMusic = Sound(fileName: "Music.Infinite", fileExtension: "mp3", type: .background)
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        let textBox = TextBoxController(skScene: self.gameScene)
        
        var texts = ["Here's the final stage: An infinite tapper! Here you can try to beat your own high-score, or you can challenge your friends!"]
        let characterImageNames: [String] = ["pro.happy"]
        
        if UIAccessibility.isVoiceOverRunning {
            texts.append(contentsOf: ["Have fun and thank you for playing!"])
        } else {
            texts.append(contentsOf: ["Have fun and thank you for playing!"])
        }
        
        textBox.texts = texts
        textBox.characterImageNames = characterImageNames
        
        self.present(textBox, animated: true, completion: nil)
        
    }
    
    override func timerDidEnd() {
        self.backgroundMusic = Sound(fileName: "Music.Infinite", fileExtension: "mp3", type: .background)
        
        let textBox = TextBoxController(skScene: self.gameScene)
        let texts: [String] = ["Nice! You got \(self.totalTaps)!"]
        let characterImageNames: [String] = ["pro.happy"]
        
        textBox.texts = texts
        textBox.characterImageNames = characterImageNames
        
        self.present(textBox, animated: true, completion: nil)
        
        self.resetGame()
        }
    }

