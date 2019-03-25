import PlaygroundSupport

let controller = TutorialLevelController()
controller.rules = [.button, .background, .dialogue, .labels, .music, .battleStart, .battleEnd]
PlaygroundPage.current.liveView = controller
PlaygroundPage.current.needsIndefiniteExecution = true
