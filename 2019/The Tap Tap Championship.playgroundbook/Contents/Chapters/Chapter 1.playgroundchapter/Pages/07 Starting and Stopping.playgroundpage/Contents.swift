//#-hidden-code
import PlaygroundSupport

var passedTimer = false

var passedDialogue = false

func startTimer() {
    passedTimer = true
    
    PlaygroundBridge.send(.battleStart)
}

func startDialogue() {
    passedDialogue = true
    
    PlaygroundBridge.send(.battleEnd)
    
}

//#-end-hidden-code

/*:
 # Starting and Stopping 🚦
 Within games, it's all about making one thing come after another, and tap battles are a perfect example! Here we have two functions: ```onBattleStart``` and ```onBattleEnd```.
 
 Inside of ```onBattleStart``` we can call the function ```startTimer``` so that once the tap battle starts, so does the timer. Then, for ```onBattleEnd``` we call the function ```startDialogue``` to transition into the dialogue. Give it a shot!
 
 💡 **Tip:** Try starting a tap battle before and after you call the functions below!
 */

//#-code-completion(everything, hide)
//#-code-completion(identifier, show, startTimer(), startDialogue())

func onBattleStart() {
    //#-editable-code
    
    //#-end-editable-code
}

func onBattleEnd() {
    //#-editable-code
    
    //#-end-editable-code
}
//#-hidden-code

onBattleStart()

onBattleEnd()

if passedTimer && passedDialogue {
    PlaygroundPage.current.assessmentStatus = .pass(message: "# Well done! \n\n With these functions, the main parts of the game are done! Next, let's look at how else we can edit the features of the game! \n\n[Next Page](@next)")
} else {
    PlaygroundPage.current.assessmentStatus = .fail(hints: [], solution: "Try this: ```startTimer()``` in the ```onBattleStart``` function and ```startDialogue()``` in the ```onBattleEnd```.")
}
//#-end-hidden-code
