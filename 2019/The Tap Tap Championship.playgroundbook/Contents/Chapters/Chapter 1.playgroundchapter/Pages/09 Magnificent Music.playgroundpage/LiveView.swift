import PlaygroundSupport
import UIKit 

let controller = TutorialLevelController()
controller.rules = [.background, .dialogue, .button, .labels, .battleStart, .battleEnd]
PlaygroundPage.current.liveView = controller
PlaygroundPage.current.needsIndefiniteExecution = true

if let keyValue = PlaygroundKeyValueStore.current["backgroundImage"],
    case .string(let backgroundImage) = keyValue {
    controller.backgroundImageView.image = UIImage(named: backgroundImage)
}
