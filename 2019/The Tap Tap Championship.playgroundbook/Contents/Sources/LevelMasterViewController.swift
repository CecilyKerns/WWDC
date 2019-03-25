//
//  ViewController.swift
//  ShibaInuGameShow
//
//  Created by Cecily Kerns on 2/20/19.
//  Copyright © 2019 Cecily Kerns. All rights reserved.
//

import UIKit
import SpriteKit

public class LevelMasterViewController: UIViewController {
    
    public let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0
        return imageView
    }()
    
    lazy var gameView: SKView = {
        let skView = SKView(frame: self.view.frame)
        skView.translatesAutoresizingMaskIntoConstraints = false
        skView.allowsTransparency = true
        return skView
    }()
    
    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.white
        label.font = UIFont(name: "Minecraft", size: 40)
        label.accessibilityLabel = "\(label) seconds remaining."
        label.alpha = 0

        label.layer.shadowOffset = CGSize.zero
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 6
        label.layer.shadowOpacity = 1
        
        return label
    }()
    
    lazy var totalTapsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tap to begin"
        label.textColor = UIColor.white
        label.font = UIFont(name: "Minecraft", size: 30)
        label.textAlignment = .center
        label.accessibilityLabel = "Tap to begin!"
        label.accessibilityElementsHidden = true
        label.alpha = 0
        
        label.layer.shadowOffset = CGSize.zero
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 6
        label.layer.shadowOpacity = 1
        return label
    }()
    
    let interactingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "button"), for: .normal)
        button.accessibilityHint = "Tap to begin your tap battle."
        
        button.layer.shadowOffset = CGSize.zero
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.8
        button.alpha = 0
        return button
    }()
    
   public var requiredTaps = 30 
    
    func updateRuleState() {
        if self.rules.contains(.button) {
            self.interactingButton.alpha = 1
        }
        
        if self.rules.contains(.background) {
            self.backgroundImageView.alpha = 1
        }
        
        if self.rules.contains(.labels) {
            self.timerLabel.alpha = 1
            self.totalTapsLabel.alpha = 1
        }
        
        if self.rules.contains(.dialogue) {
            self.gameScene.alpha = 1
        }
        
        if self.rules.contains(.music) {
            
        }
        
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var gameScene = GameScene()
    var backgroundMusic: Sound? = nil {
        didSet {
            if self.rules.contains(.music) {
            self.gameScene.backgroundMusicSound = backgroundMusic
            }
        }
    }
    
    var timer: Timer?
    var totalTaps = 0 {
        didSet {
            // This code is executed whenever totalTaps changes
            self.totalTapsLabel.text = "\(self.totalTaps) taps"
        }
    }
    
    var secondsRemainingOnTimer: Int = 10 {
        didSet {
            // This code is executed whenever secondsRemainingOnTimer changes
            self.timerLabel.text = "\(self.secondsRemainingOnTimer) seconds remaining"
        }
    }
    
    public var rules: [PlaygroundRules] = [] {
        didSet {
            self.updateRuleState()
        }
    }
    
    public init() {
        let cfURL = Bundle.main.url(forResource: "Minecraft", withExtension: "ttf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   public func presentIntroTextBox() {
        
    }
    
   public func presentEnd() {
        
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        if self.rules.contains(.dialogue) {
            self.presentIntroTextBox() 
        }
    }

    override public func viewDidLoad() {
        self.updateRuleState()
        
        self.backgroundImageView.accessibilityTraits = UIAccessibilityTraits.allowsDirectInteraction
        self.interactingButton.accessibilityTraits = UIAccessibilityTraits.allowsDirectInteraction
        
        self.view.addSubview(self.backgroundImageView)
        self.view.addSubview(self.gameView)
        self.view.addSubview(self.timerLabel)
        self.view.addSubview(self.totalTapsLabel)
        self.view.addSubview(self.interactingButton)
        
        self.setupConstraints()
        
        self.gameScene.scaleMode = .aspectFill
        self.gameView.presentScene(self.gameScene)
        
        self.interactingButton.addTarget(self, action: #selector(userDidTapOnButton), for: .touchUpInside)
    }
    
    func showButton() {
        self.interactingButton.alpha = 1
    }
    
    func showBackground() {
        self.backgroundImageView.alpha = 1
    }
    
    func showLabels() {
        self.timerLabel.alpha = 1
        self.totalTapsLabel.alpha = 1
    }
    
    func showDialogue() {
        self.gameScene.alpha = 1
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        self.gameScene.stopBackgroundMusic()
    }
    
    func setupConstraints() {
        self.backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.totalTapsLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100).isActive = true
        self.totalTapsLabel.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor).isActive = true
        self.totalTapsLabel.trailingAnchor.constraint(equalTo: self.view.readableContentGuide.trailingAnchor).isActive = true
        
        self.timerLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.timerLabel.bottomAnchor.constraint(equalTo: self.totalTapsLabel.topAnchor).isActive = true
        self.timerLabel.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor).isActive = true
        self.timerLabel.trailingAnchor.constraint(equalTo: self.view.readableContentGuide.trailingAnchor).isActive = true
        
        self.gameView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.gameView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.gameView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.gameView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.interactingButton.topAnchor.constraint(equalTo: self.totalTapsLabel.bottomAnchor).isActive = true
        self.interactingButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    var countingDown = false
    
    
    @objc func userDidTapOnButton() {
        if self.timer == nil && !self.countingDown && self.rules.contains(.battleStart) {
            // We haven't started counting down
            self.totalTaps = 0
            self.countingDown = true
            UIAccessibility.post(notification: .announcement, argument: "Starting in 3")
            
            self.timerLabel.text = "Starting in 3..."
            
            UIView.animate(withDuration: 0.4) {
                self.timerLabel.alpha = 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                self.timerLabel.text = "Starting in 2..."
                UIAccessibility.post(notification: .announcement, argument: "2")
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                    self.timerLabel.text = "Starting in 1..."
                    UIAccessibility.post(notification: .announcement, argument: "1")
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                        self.countingDown = false
                        
                        self.secondsRemainingOnTimer = 10
                        
                        if UIAccessibility.isVoiceOverRunning {
                            self.secondsRemainingOnTimer = 15
                        }
                        
                        self.backgroundMusic = Sound(fileName: "Music.Battle", fileExtension: "mp3", type: .background)
                        UIAccessibility.post(notification: .announcement, argument: "Go!")
                        
                        
                        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
                            self.secondsRemainingOnTimer -= 1
                            
                            if self.secondsRemainingOnTimer <= 0 {
                                self.timer?.invalidate() // Stop running the timer
                                self.timerDidEnd()
                                return
                            }
                        })
                    }
                }
            }
        return
        }
        
        if self.secondsRemainingOnTimer <= 0 || self.countingDown || !self.rules.contains(.battleStart) {
            return
        }
        
        self.totalTaps += 1
    }
    
    func timerDidEnd() {
    }
    
    func resetGame() {
        self.totalTaps = 0
        self.secondsRemainingOnTimer = 10
        self.timer = nil
        
        UIView.animate(withDuration: 0.4) {
            self.timerLabel.alpha = 0
        }
        
        self.totalTapsLabel.text = "Tap to begin."
    }
    
}

