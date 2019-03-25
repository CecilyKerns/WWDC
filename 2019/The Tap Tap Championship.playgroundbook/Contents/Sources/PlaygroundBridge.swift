import PlaygroundSupport
import UIKit 

public class PlaygroundBridge {
    
    public class func send(_ message: PlaygroundBridgeMessage, data: String = "") {
        let liveController = PlaygroundPage.current.liveView as? PlaygroundRemoteLiveViewProxy
        
        let dictionary: [String : PlaygroundValue] = ["message" : PlaygroundValue.string(message.rawValue), "body" : PlaygroundValue.string(data)]
        
        liveController?.send(PlaygroundValue.dictionary(dictionary))
    }
    
}

public enum PlaygroundBridgeMessage: String {
    
    case button
    case background
    case labels
    case music
    case dialogue
    case requiredTaps
    case battleStart
    case battleEnd
    
}

// This should be an extension of whatever your "main" ViewController is, not really its own class.
// E.g
// extension MyMainViewController: PlaygroundLiveViewMessageHandler
extension LevelMasterViewController: PlaygroundLiveViewMessageHandler {
    
    open func receive(_ message: PlaygroundValue) {
        guard case let PlaygroundValue.dictionary(messageDictionary) = message else {
            return
        }
        
        guard let message = messageDictionary["message"], case let PlaygroundValue.string(messageValue) = message, let bridgeMessage = PlaygroundBridgeMessage(rawValue: messageValue) else {
            return
        }
        
        guard let bodyValue = messageDictionary["body"], case let PlaygroundValue.string(bodyString) = bodyValue else {
            return
        }
        
        switch bridgeMessage {
        case .button:
            self.rules = [.button]
            break
            
        case .labels:
            self.rules = [.labels]
            break 
            
        case .background:
            self.rules = [.background]
            self.backgroundImageView.image = UIImage(named: bodyString)
            break
            
        case .music:
            self.rules = [.music]
            self.backgroundMusic = Sound(fileName: bodyString, fileExtension: "mp3", type: .background)
            break
            
        case .dialogue:
            self.rules = [.dialogue]
            self.presentIntroTextBox() 
            break
            
        case .requiredTaps:
            self.requiredTaps = Int(bodyString) ?? 30
            break
            
        case .battleStart:
            self.rules.append(.battleStart)
            break
            
        case .battleEnd:
            self.rules.append(.battleEnd)
            break
        }
    }
    
}
