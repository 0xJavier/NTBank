# NTBank

NTBank is an app aimed to streamline the Monopoly experience by removing the need for paper money and a dedicated banker. Each player now has a customizable card that displays their current balance and allows them to send money to other players and react to in game events all through the app. You no longer need to setup and count paper money in the beginning or end of the game as the app keeps up to date rankings of each player.

![](https://github.com/0xJavier/NTBank/blob/master/Screenshots/NTScreenshots.png)

From its humble beginnings as an app using all storyboards and massive view controllers to its current state, NTBank is the product of my self taught journey. This was an awesome personal project to work on as it was a real world problem I had to take from designing in Sketch to a finished product. Through its many iterations, the app has seen many improvements as I learned to be a better developer. Its first iteration had 600 line view controllers with UI + Business logic all in one. Now it consists of MVVM architecture with separated business logic that can be tested and combine bindings. I am very proud of the finished product as I went from following tutorials and trying to understand iOS development to having my own app being used by family.

## App Features
* Keep track of your balance with color customizable cards.
* Streamline game actions with quick actions and keep track of your spending with the transaction history.
* Quickly send money to the bank, lottery, or other players.
* Always know who is leading the game with up to date rankings.
* Win big through the lottery as it grows throughout the game.

## Technologies Used
* Swift + UIKit.
* MVVM app architecture.
* Combine for basic form validation + ViewModel binding.
* Firebase backend through SPM.
* Async/await for network calls.
* Programatic UI.
* Separation of concern for service classes and carving datasources away from view controllers.
* Dark mode support.
