//#-hidden-code
import PlaygroundSupport

var passed = false

var requiredTaps = 0 {
    didSet {
        PlaygroundBridge.send(.requiredTaps, data: String(requiredTaps))
        passed = true
    }
}
//#-end-hidden-code

/*:
 # Reining in Requirements 🔓
 Congrats! The game is now functional! But, other complex parts of the game are stil hidden away in the shadows. Let's bring them out so they can be understood, shall we?
 
 Firstly, we have a variable called ```totalTaps```. It tracks the amount of times you tap during tap battles. Various characters reference your tap score, it's displayed through a label, and it determines if you pass the level or not. How does it work?
 
 To start, let's look this function:
 
 ```
 func userDidTapOnButton() {
    totalTaps += 1
 }
 ```
 
 This function is called when the user taps on the button and with every time that ```userDidTapOnButton``` is called, ```totalTaps``` adds 1 to its current value. This enables the game to track your tap score with ease.
 
 Now, let's try out this concept with another variable added in! ```requiredTaps``` is a variable which is used alongside ```totalTaps``` to make it possible to pass or fail each level. Mess around with the variable ```requiredTaps``` to see how you can change the value of ```totalTaps``` needed in order to pass the level.
 
 💡 **Tip:** After changing the required taps, start a tap battle to see what has changed! (P.S. The original required amount of taps is 30, I'd suggest trying out a lower number, then a higher number to see what happens!
 */

//#-code-completion(everything, hide)
//#-code-completion(identifier, show, 10, 20, 40)

requiredTaps = /*#-editable-code*/  /*#-end-editable-code*/

//#-hidden-code

if passed {
    PlaygroundPage.current.assessmentStatus = .pass(message: "# Perfect! \n\n Now you can change the required taps to whatever you want! However, I think we're still missing one thing... Music, let's fix that! \n\n[Next Page](@next)")
} else {
    PlaygroundPage.current.assessmentStatus = .fail(hints: ["Check the solution if you are stuck."], solution: "Try this: ```20```")
}
//#-end-hidden-code
