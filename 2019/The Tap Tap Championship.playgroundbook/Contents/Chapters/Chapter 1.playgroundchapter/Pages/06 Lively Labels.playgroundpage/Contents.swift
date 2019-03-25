//#-hidden-code
import PlaygroundSupport

var passed = false

func showLabels() {
    PlaygroundBridge.send(.labels)
    
    passed = true
}
//#-end-hidden-code

/*:
 # Lively Labels 🏷
 Now we have our button visible, but it can't do anything yet. We can't start a tap battle or see how many taps we got in general. Let's change that!
 
 What we need is something called a [label](glossary://Label)! In this game, I used labels to display the time left during the current tap battle and to display how many taps the user got overall.
 
 We'll need to call a new function in order to bring the labels back! In this case, it's a function called ```showLabels()```. Try it out, but be careful, this time you don't have a placeholder hinting at you what to type. Good luck!*/

//#-code-completion(everything, hide)
//#-code-completion(identifier, show, showLabels())

/*#-editable-code */    /*#-end-editable-code*/

//#-hidden-code

if passed {
    PlaygroundPage.current.assessmentStatus = .pass(message: "# Cool beans! \n\n Now you can see the text above the button! Next, we'll be looking at the features of the battle system and how to edit them. \n\n[Next Page](@next)")
} else {
    PlaygroundPage.current.assessmentStatus = .fail(hints: ["Check the solution if you are stuck."], solution: "Try this: ```showLabels()```")
}
//#-end-hidden-code
