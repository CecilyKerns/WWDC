//#-hidden-code
import PlaygroundSupport

var passed = false

enum Background: String {
    case lobby = "lobby.background"
    case balcony = "balcony.background"
    case boss = "boss.background"
}

var backgroundImage: Background = .lobby {
    didSet {
        PlaygroundBridge.send(.background, data: backgroundImage.rawValue)
        PlaygroundKeyValueStore.current["backgroundImage"] = .string(backgroundImage.rawValue)
        passed = true
    }
}
//#-end-hidden-code


/*:
 # Beautiful Backgrounds 🌅
 Now that you have an idea of the game, let's strip all the elements away so you can build it! Seems empty, doesn't it? Don't worry, you're going to change that!
 
 Let's start from the very beginning. First, we need something on the screen: A background! In order to add a background, you'll need to use something called a [variable](glossary://Variable)! A variable is something in which you can store tidbits of information. You can change the information inside the variable at any time!
 
 Now we can use this concept of variables for our background. If you look at the editable code below this line of text, you can see this idea in action. Go on and input ```.lobby```, ```.balcony```, or ```.boss``` as the new ```backgroundImage``` value!*/

//#-code-completion(everything, hide)
//#-code-completion(identifier, show, ., lobby, balcony, boss)

backgroundImage = /*#-editable-code */<#.lobby#>/*#-end-editable-code*/

//#-hidden-code

if passed {
    PlaygroundPage.current.assessmentStatus = .pass(message: "# Good choice! \n\n You're definitely getting the hang of this! Now, onto bringing back the dialogue with our trainer, Maia the Shiba Inu. \n\n[Next Page](@next)")
} else {
    PlaygroundPage.current.assessmentStatus = .fail(hints: ["Check the solution if you are stuck."], solution: "Try writing this: ```self.backgroundImageName = .lobby```")
}
//#-end-hidden-code
