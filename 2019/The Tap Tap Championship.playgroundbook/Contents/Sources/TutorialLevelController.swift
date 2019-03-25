//
//  TutorialLevelController.swift
//  ShibaInuGameShow
//
//  Created by Cecily Kerns on 2/23/19.
//  Copyright © 2019 Cecily Kerns. All rights reserved.
//
import UIKit

public class TutorialLevelController: LevelMasterViewController {
    
    var introductionPresented: Bool = false
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        print (UIImage(named: "lobby.background") == nil)
        
        self.requiredTaps = 30
        if UIAccessibility.isVoiceOverRunning {
            requiredTaps = 20
        }
        
        self.backgroundImageView.image = UIImage(named: "lobby.background")
        self.backgroundMusic = Sound(fileName: "Music.Tutorial", fileExtension: "mp3", type: .background)
    }
    
    override public func presentIntroTextBox() {
        if !self.introductionPresented {
            self.introductionPresented = true
            
            if self.rules.contains(.dialogue) {
        
            let textBox = TextBoxController(skScene: self.gameScene)
            
            var texts: [String] = ["Hey there! Welcome to the Tap Tap Championship!",
                                   "Are you here to battle to become the Tap Tap Champ?",
                                   "What?!? You don't know what the Tap Tap Championship is?",
                                   "It's a huge competition where lots of people get together to test their tapping and there's a big trophy for the winner!",
                                   "Here, since you're already in the building, why don't you enter? It's super easy to learn!",
                                   "Nice! Well, let me give you a bit of training before you go!",
                                   "To start, let me explain the rules:"]
            let characterImageNames: [String] = ["character.normal",
                                                 "character.normal",
                                                 "character.confused",
                                                 "character.smug",
                                                 "character.normal",
                                                 "character.happy",
                                                 "character.smug",
                                                 "character.happy",
                                                 "character.normal",
                                                 "character.smug",
                                                 "character.happy",
                                                 "character.smug",
                                                 "character.happy"]
            
            if UIAccessibility.isVoiceOverRunning {
                texts.append(contentsOf: ["There's a big button right behind me in the center of the screen that you're gonna tap as fast as you can!",
                                          "The number you get after tapping for 15 seconds is your TAP SCORE!",
                                          "You'll be going up against challengers to beat their TAP SCORE within 15 seconds.",
                                          "If you beat their TAP SCORE, you'll move up.",
                                          "If you don't. Well, there's always a participation award!",
                                          "Here, try to battle me! If you can get over 20 taps in 15 seconds, then you win!",
                                          "To start, all you do is double tap the center of the screen, once the music kicks up, it's go time!"])
            } else {
                texts.append(contentsOf: ["There's a big button right behind me that you're gonna tap as fast as you can!",
                                          "The number you get after tapping for 10 seconds is your TAP SCORE!",
                                          "You'll be going up against challengers to beat their TAP SCORE within 10 seconds.",
                                          "If you beat their TAP SCORE, you'll move up.",
                                          "If you don't... Well, there's always a participation award!",
                                          "Here, try to battle me! If you can get over 30 taps in 10 seconds, then you win!",
                                          "To start, all you do is tap the big button, once the music kicks up, it's go time!"] )
            }
            
            textBox.texts = texts
            textBox.characterImageNames = characterImageNames
            
            self.present(textBox, animated: true, completion: nil)
                
            }
        }
    }
    
    
    override func timerDidEnd() {
        self.backgroundMusic = Sound(fileName: "Music.Tutorial", fileExtension: "mp3", type: .background)
        
        if !self.rules.contains(.battleEnd){
            return
        }
        
        var texts: [String] = []
        var characterImageNames: [String] = []
        
        let textBox = TextBoxController(skScene: self.gameScene)
        
        if self.totalTaps < requiredTaps {
            texts.append("Erm. \(self.totalTaps) taps is not enough. Try again! I know you can do it!")
            characterImageNames.append("character.confused")
            
            textBox.textBoxDismissed = { [weak self] in
                self?.resetGame()
            }
        } else {
            texts.append("You did it! Wow, \(self.totalTaps) is really something!")
            characterImageNames.append("character.happy")
            
            texts.append("You're gonna do great in the Tap Tap Championship! C'mon, I'll take you there now!")
            characterImageNames.append("character.normal")
            
            UIView.animate(withDuration: 0.4) {
                self.interactingButton.alpha = 0
                self.timerLabel.alpha = 0
                self.totalTapsLabel.alpha = 0
            }
            
            textBox.textBoxDismissed = { [weak self] in
                let controller = FirstLevelController()
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


