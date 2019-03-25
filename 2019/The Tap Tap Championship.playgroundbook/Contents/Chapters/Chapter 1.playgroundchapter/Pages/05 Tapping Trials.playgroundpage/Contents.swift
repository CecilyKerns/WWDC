//#-hidden-code
import PlaygroundSupport

var passed = false

func showButton() {
    PlaygroundBridge.send(.button)
    
    passed = true
}
//#-end-hidden-code

/*:
 # Tapping Trials 🔘
We've come pretty far in terms of the look and heart of our game, but it still has no functionality. Let's re-introduce our button! To make our button appear, we'll need to call another function.
 
 For this, we'll use a function called ```showButton()```. This will make our button reappear on the screen.
 
 Go on and try to summon the button!
 
 💡 **Tip:** Skip the dialogue before calling the function so you can see the button pop up before your eyes!
*/

//#-code-completion(everything, hide)
//#-code-completion(identifier, show, showButton())

/*#-editable-code */<#showButton()#>/*#-end-editable-code*/

//#-hidden-code

if passed {
    PlaygroundPage.current.assessmentStatus = .pass(message: "# Awesome!!! \n\n You made the button appear! Next let's make the text above the button reappear too. \n\n[Next Page](@next)")
} else {
    PlaygroundPage.current.assessmentStatus = .fail(hints: [], solution: "Try this: ```showButton()``` ")
}
//#-end-hidden-code
