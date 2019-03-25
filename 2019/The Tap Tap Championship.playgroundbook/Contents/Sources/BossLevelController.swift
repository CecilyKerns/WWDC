//
//  BossLevelController.swift
//  ShibaInuGameShow
//
//  Created by Cecily Kerns on 2/24/19.
//  Copyright © 2019 Cecily Kerns. All rights reserved.
//

import UIKit

public class BossLevelController: LevelMasterViewController {
    
    let trophyImageView: UIImageView = {
        let trophy = UIImageView()
        trophy.translatesAutoresizingMaskIntoConstraints = false
        trophy.image = UIImage(named: "Trophy")
        trophy.alpha = 0
        return trophy
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.backgroundImageView.image = UIImage(named: "boss.background")
        self.backgroundMusic = Sound(fileName: "Music.Boss", fileExtension: "mp3", type: .background)
        
        self.requiredTaps = 60
        if UIAccessibility.isVoiceOverRunning {
            requiredTaps = 50
        }
        
        self.hideTrophyView()
        
        self.view.addSubview(self.trophyImageView)
        
        // Constraints
        
        self.trophyImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.trophyImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.trophyImageView.widthAnchor.constraint(equalToConstant: 400).isActive = true
        self.trophyImageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
    
    func hideTrophyView() {
        self.trophyImageView.alpha = 0
        self.trophyImageView.transform = self.trophyImageView.transform.translatedBy(x: 0, y: 300)
    }
    
    func showTrophyView() {
        self.trophyImageView.alpha = 1
        self.trophyImageView.transform = .identity
    }
    
    override public func presentIntroTextBox() {
        
        if self.rules.contains(.dialogue) {
            
        let textBox = TextBoxController(skScene: self.gameScene)
        var texts = ["Well kid, you seem pretty good, but don't get too cocky. You haven't seen anything up till now.",
                     "Like your trainer said, I'm The Programmer.",
                     "Over all the hours of ENDLESS testing and debugging my tapping skills became extremely advanced."]
        let characterImageNames: [String] =
            ["pro.sill",
             "pro.happy",
             "pro.normal",
             "pro.happy"]
        
        if UIAccessibility.isVoiceOverRunning {
            texts.append(contentsOf: ["If you want to win, you'll need to beat my score of 50 taps.",
                                      "Good luck. You'll need it."])
        }
            
        else {
            texts.append(contentsOf: ["If you want to win, you'll need to beat my score of 60 taps.",
                                      "Good luck. You'll need it."])
        }
        textBox.texts = texts
        textBox.characterImageNames = characterImageNames
        
        self.present(textBox, animated: true, completion: nil)
        }
    }
    
    override func timerDidEnd() {
        
        var texts: [String] = []
        var characterImageNames: [String] = []
        
        let textBox = TextBoxController(skScene: self.gameScene)
        
        if self.totalTaps < requiredTaps {
            self.backgroundMusic = Sound(fileName: "Music.Boss", fileExtension: "mp3", type: .background)
            
            texts.append("You tried, I'll give you that. Guess it's time to call the resetGame() function.")
            characterImageNames.append("pro.normal")
            
            textBox.textBoxDismissed = { [weak self] in
                self?.resetGame()
            }
            
            textBox.texts = texts
            textBox.characterImageNames = characterImageNames
            
            self.present(textBox, animated: true, completion: nil)
        } else {
            self.backgroundMusic = Sound(fileName: "Music.Win", fileExtension: "mp3", type: .background)
            
            texts.append("Huh.")
            characterImageNames.append("pro.sill")
            
            texts.append("You. You actually won. You know, I could make you lose with a little youLose() function but I probably shouldn't do that.")
            characterImageNames.append("pro.surprised")
            
            texts.append("After all, you beat me fair and square, kid. I guess you're the new champion now.")
            characterImageNames.append("pro.happy")
            
            texts.append("Great job! I knew you could do it! You're the new Tap Tap Champ! Let's go celebrate!")
            characterImageNames.append("character.happy")
            
            texts.append("THE END")
            characterImageNames.append("nothing")
            
            texts.append("Wait! Before you go, let me show you one last thing... As a little congrats to your win!")
            characterImageNames.append("pro.happy")
            
            UIView.animate(withDuration: 0.6) {
                self.showTrophyView()
                
                self.interactingButton.alpha = 0
                self.timerLabel.alpha = 0
                self.totalTapsLabel.alpha = 0
                
                textBox.textBoxDismissed = { [weak self] in
                    let controller = InfiniteLevelController()
                    controller.modalTransitionStyle = .crossDissolve
                    controller.rules = self!.rules
                    self?.present(controller, animated: true, completion: nil)
                    self?.gameScene.stopBackgroundMusic()
                }
            }
            
            textBox.texts = texts
            textBox.characterImageNames = characterImageNames
            
            // Timer that after 1.0 seconds shows the text box
            
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                self.present(textBox, animated: true, completion: nil)
            }
        }
    }
}
