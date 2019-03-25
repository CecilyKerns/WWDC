//#-hidden-code
import PlaygroundSupport

var passed = false

enum Music: String {
    case lobby = "Music.Tutorial"
    case balcony = "Music.FirstLevel"
    case boss = "Music.Boss"
}

var backgroundMusic: Music = .lobby {
    didSet {
        PlaygroundBridge.send(.music, data: backgroundMusic.rawValue)
        passed = true
    }
}
//#-end-hidden-code

/*:
 # Magnificent Music 🎵
 And now... The last piece of the puzzle: Music. The element of music is crucial in setting the mood and making sure a user's experience with our program is a good one.
 
 With music in mind, let's go back to the idea of variables expressed in "Beautiful Backgrounds," where you can customize the music for this portion to your liking through editing the variable: ```backgroundMusic```'s value.
 
 Go on and change ```backgroundMusic```'s value to ```.lobby```, ```.balcony```, or ```.boss.```*/

//#-code-completion(everything, hide)
//#-code-completion(identifier, show, ., lobby, balcony, boss)

backgroundMusic = /*#-editable-code*/ /*#-end-editable-code*/

//#-hidden-code

if passed {
    PlaygroundPage.current.assessmentStatus = .pass(message: "# Amazing job! \n\n You've completed the game!!! Now, I guess it's time to say goodbye... \n\n[Next Page](@next)")
} else {
    PlaygroundPage.current.assessmentStatus = .fail(hints: ["Check the solution if you are stuck."], solution: "Try writing this: ```backgroundMusic = .lobby```")
}
//#-end-hidden-code
