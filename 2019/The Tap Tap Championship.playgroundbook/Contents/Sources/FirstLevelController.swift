//
//  FirstLevelController.swift
//  ShibaInuGameShow
//
//  Created by Cecily Kerns on 2/23/19.
//  Copyright © 2019 Cecily Kerns. All rights reserved.
//

import UIKit

public class FirstLevelController: LevelMasterViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.backgroundImageView.image = UIImage(named: "balcony.background")
        self.backgroundMusic = Sound(fileName: "Music.FirstLevel", fileExtension: "mp3", type: .background)
        
        self.requiredTaps = 45
        if UIAccessibility.isVoiceOverRunning {
            requiredTaps = 35
        }
    }
    
    override public func presentIntroTextBox() {
        
        if self.rules.contains(.dialogue) {
            
        let textBox = TextBoxController(skScene: self.gameScene)
            
        var texts = ["Here we are! The Tap Tap Championship!", "Well, now it's time for you to go out and challenge some other competitors.", "Oh! Look over there, that cat looks ready and rearing to go! Give it a shot!", "Hey! Who let the baby in? Awe, the little noobie wants to battle!", ]
        let characterImageNames: [String] = ["character.happy", "character.normal", "character.smug", "cat.normal"]
        
        if UIAccessibility.isVoiceOverRunning {
            texts.append(contentsOf: ["Just try and beat my TAP SCORE of 35, just try."])
        }
            
        else {
            texts.append(contentsOf: ["Just try and beat my tap score of 45, just try."])
        }
        textBox.texts = texts
        textBox.characterImageNames = characterImageNames
        
        self.present(textBox, animated: true, completion: nil)
        } 
    }
    
    override func timerDidEnd() {
        self.backgroundMusic = Sound(fileName: "Music.FirstLevel", fileExtension: "mp3", type: .background)
        
        var texts: [String] = []
        var characterImageNames: [String] = []
        
        let textBox = TextBoxController(skScene: self.gameScene)
        
        if self.totalTaps < requiredTaps {
            texts.append("Hah! Gotcha kiddie! \(self.totalTaps) ain't gonna cut it! Try again if ya want, I'm not scared of you.")
            characterImageNames.append("cat.smug")
            
            textBox.textBoxDismissed = { [weak self] in
                self?.resetGame()
            }
        } else {
            texts.append("What? You beat me! That isn't right.")
            characterImageNames.append("cat.angry")
            
            texts.append("Hey. Who's that kid over there who beat Catty McCatFace to a pulp? Let me through, I want to see them.")
            characterImageNames.append("pro.sill")
            
            texts.append("Oh no. That's The Programmer. She's a crazy good tapper, she made the game after all. You're toast!")
            characterImageNames.append("character.scared")
            
            texts.append("Kid, you might just be something. Let me take you to my office, I think I'd like to battle you.")
            characterImageNames.append("pro.sill")
            
            texts.append("What?!? Miss Programmer, this kid is a complete beginner, it's not fair to battle them so early like this!")
            characterImageNames.append("character.scared")
            
            texts.append("You want to win, don't you? You gotta beat me to win. C'mon, let's go.")
            characterImageNames.append("pro.sill")
            
            
            UIView.animate(withDuration: 0.4) {
                self.interactingButton.alpha = 0
                self.timerLabel.alpha = 0
                self.totalTapsLabel.alpha = 0
            }
            
            textBox.textBoxDismissed = { [weak self] in
                let controller = BossLevelController()
                controller.rules = self!.rules
                controller.modalTransitionStyle = .crossDissolve
                self?.present(controller, animated: true, completion: nil)
                self?.gameScene.stopBackgroundMusic()
            }
        }
        
        textBox.texts = texts
        textBox.characterImageNames = characterImageNames
        
        self.present(textBox, animated: true, completion: nil)
    }
    
}
