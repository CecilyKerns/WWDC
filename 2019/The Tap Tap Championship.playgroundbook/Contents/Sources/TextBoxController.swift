//
//  TextBoxController.swift
//  ShibaInuGameShow
//
//  Created by Cecily Kerns on 2/20/19.
//  Copyright © 2019 Cecily Kerns. All rights reserved.
//

import UIKit
import SpriteKit

public class TextBoxController: UIViewController {
    
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isAccessibilityElement = false
        return imageView
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Minecraft", size: 16)
        textView.textColor = UIColor.black
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false
        textView.accessibilityTraits = .button
        textView.accessibilityHint = "Tap to continue."
        return textView
    }()
    
    let skipButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Skip Dialogue", for: .normal)
        button.titleLabel?.font = UIFont(name: "Minecraft", size: 12)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    var skScene: SKScene
    
    var texts: [String] = []
    var text: String
    var currentTextIndex = -1
    var currentlyAnimatingText = false
    
    var characterImageName: String
    var characterImageNames: [String] = []
    var currentCharacterIndex = -1
    
    var textBoxDismissed: (() -> Void)? = nil
    
    let blipSound = Sound(fileName: "boxblip", fileExtension: "wav", type: .effect)
    
    init(skScene: SKScene, text: String = "", texts: [String] = [], characterImageName: String = "", characterImageNames: [String] = []) {
        self.text = text
        self.texts = texts
        self.skScene = skScene
        self.characterImageName = characterImageName
        self.characterImageNames = characterImageNames
        
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
        self.accessibilityViewIsModal = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        self.view.addSubview(self.characterImageView)
        
        self.view.addSubview(self.containerView)
        self.containerView.addSubview(self.textView)
        
        self.view.addSubview(self.skipButton)
        
        self.setupConstraints()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapOnTextBox))
        self.containerView.addGestureRecognizer(tapRecognizer)
        self.view.addGestureRecognizer(tapRecognizer)
        
        self.skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
    }
    
    @objc func skipButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapOnTextBox() {
        guard !self.currentlyAnimatingText else {
            return
        }
        
        if !self.characterImageNames.isEmpty && self.currentCharacterIndex != self.characterImageNames.count - 1 {
            self.animateCharacter()
        }
        
        // If texts list size is not empty AND we still have more text in our texts list that we haven't shown
        if !self.texts.isEmpty && self.currentTextIndex != self.texts.count - 1 {
            self.animateText()
            return
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupConstraints() {
        self.characterImageView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
        self.characterImageView.bottomAnchor.constraint(equalTo: self.textView.centerYAnchor).isActive = true
        self.characterImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.characterImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        self.containerView.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor).isActive = true
        self.containerView.trailingAnchor.constraint(equalTo: self.view.readableContentGuide.trailingAnchor).isActive = true
        self.containerView.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 70).isActive = true
        
        self.skipButton.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
        self.skipButton.topAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: 10).isActive = true
        
        self.textView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -10).isActive = true
        self.textView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 10).isActive = true
        self.textView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10).isActive = true
        self.textView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -10).isActive = true
    }
    
    override public func viewDidDisappear(_ animated: Bool) {
        self.textBoxDismissed?()
    }
    
}

// MARK: Animation Extension

extension TextBoxController {
    
    // MARK: Entrance and Exit Animations
    
    override public func viewWillAppear(_ animated: Bool) {
        self.hideContainerView()
        
        UIView.animate(withDuration: 0.3) {
            self.showContainerView()
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.008, repeats: false) { _ in
            self.animateText()
            self.animateCharacter()
        }
        
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.hideContainerView()
        }
    }
    
    func hideContainerView() {
        self.containerView.alpha = 0
        self.containerView.transform = self.containerView.transform.translatedBy(x: 0, y: 100)
    }
    
    func showContainerView() {
        self.containerView.alpha = 1
        self.containerView.transform = .identity
    }
    
    //MARK: Animate Character
    
    func animateCharacter() {
        if self.currentCharacterIndex == -1 {
            self.characterImageView.alpha = 0
            
            UIView.animate(withDuration: 0.3) {
                self.characterImageView.alpha = 1
            }
        }
        
        if !self.characterImageNames.isEmpty {
            self.currentCharacterIndex += 1
            self.characterImageName = self.characterImageNames[self.currentCharacterIndex]
        }
        
        self.characterImageView.image = UIImage(named: self.characterImageName)
    }
    
    // MARK: Text Animations
    
    func animateText() {
        self.textView.text = ""
        
        if !self.texts.isEmpty {
            self.currentTextIndex += 1
            self.text = self.texts[self.currentTextIndex]
        }
        
        self.currentlyAnimatingText = true
        
        // Make a loop for each character in our current text!
        // Says: For every character, I want the index (position) and the character!
        
        for (index, character) in self.text.enumerated() {
            let duration = UIAccessibility.isVoiceOverRunning ? 0 : 0.05
            Timer.scheduledTimer(withTimeInterval: duration * Double(index), repeats: false, block: { [weak self] _ in
                guard let strongSelf = self else {
                    return
                }
                
                if !UIAccessibility.isVoiceOverRunning {
                    AudioPlayer.shared.play(sound: strongSelf.blipSound, on: strongSelf.skScene)
                }
                
                strongSelf.textView.text.append(character)
                
                // If we have reached the end, then set currently animating to false. (Prevents text box bug of skipping over dialogue)
                if index == strongSelf.text.count - 1 {
                    strongSelf.currentlyAnimatingText = false
                    UIAccessibility.post(notification: UIAccessibility.Notification.screenChanged, argument: strongSelf.textView)
                }
            })
        }
    }
    
}
