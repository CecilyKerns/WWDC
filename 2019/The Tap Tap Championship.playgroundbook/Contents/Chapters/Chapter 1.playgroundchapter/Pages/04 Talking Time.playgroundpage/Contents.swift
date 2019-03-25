//#-hidden-code
import PlaygroundSupport

var passed = false

func showDialogue() {
    PlaygroundBridge.send(.dialogue)
    
    passed = true
}
//#-end-hidden-code

/*:
 # Talking Time 🎙
 Even though we have the background, the game is still looking pretty empty. We need something that is going to give it a lot of pep and heart...
 
 The dialogue! This is definitely the most important part of the game, because it brings lots of color and humor into the mix. In order to make it appear, however, you're going to need to do something a bit different from what you did before with your variable.
 
 This time around, you're going to need to call a [function](glossary://Function). Functions are collections of little bits of code, smashed together into one easy phrase that can be used at any time. The format for a function is the name first, then a pair of parentheses which call the function. It looks like this: ```functionName()```.
 
 For our code, we have a function called, ```onGameStart```, which is called once the game begins. Within ```onGameStart``` you'll want to call ```showDialogue()``` so that the dialogue starts once the game does.*/

//#-code-completion(everything, hide)
//#-code-completion(identifier, show, showDialogue())

func onGameStart() {
    //#-editable-code
    <#showDialogue()#>
    //#-end-editable-code
}
//#-hidden-code

onGameStart()

if passed {
    PlaygroundPage.current.assessmentStatus = .pass(message: "# Sweet! \n\n  Now that the dialogue is back, let's add our button. \n\n[Next Page](@next)")
} else {
    PlaygroundPage.current.assessmentStatus = .fail(hints: ["Check the solution if you are stuck."], solution: "Try this: ```showDialogue()```")
}
//#-end-hidden-code
