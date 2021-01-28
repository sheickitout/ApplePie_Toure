//
//  ViewController.swift
//  ApplePie_Toure
//“On my honor, I have neither received nor given any unauthorized assistance on Midterm Exam .”
//  Created by Sheick on 10/26/20.
//

import UIKit

class ViewController: UIViewController {
    var listOfWords = ["buccaneer", "swift", "glorious", "incandescent", "bug","program"]
    let incorrectMovesAllowed = 7
        var totalWins = 0 {
            didSet {
                newRound()
            }
        }

        var totalLosses = 0 {
            didSet {
                newRound()
            }
        }

        @IBOutlet var letterButtons: [UIButton]!
    
        @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
            let letterString = sender.title(for: .normal)!
            let letter = Character(letterString.lowercased())
            currentGame.playerGuessed(letter: letter)
//            updateUI()
            updateGameState()

        }

        @IBOutlet weak var scoreLabel: UILabel!
        @IBOutlet weak var correctWordLabel: UILabel!
        @IBOutlet weak var treeImageView: UIImageView!

        override func viewDidLoad() {
            super.viewDidLoad()
            newRound()
            
        }

        func enableLetterButtons (_enable: Bool){
            for button in letterButtons {
                button.isEnabled = _enable
            }
        }

        var currentGame : Game!

        func newRound() {
            if !listOfWords.isEmpty{
               let newWord = listOfWords.removeFirst()
                currentGame = Game (word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
                enableLetterButtons(_enable: true)
                updateUI()
            } else {
                enableLetterButtons (_enable: false)
            }

        }

        func updateUI() {
            var letters = [String] ()
            for letter in currentGame.formattedWord {
                letters.append(String(letter))
            }
            let wordWithSpacing = letters.joined(separator: " ")
            correctWordLabel.text = wordWithSpacing
            scoreLabel.text = "Wins: \(totalWins), Losses:\(totalLosses)"
            treeImageView.image = UIImage (named: "Tree \(currentGame.incorrectMovesRemaining)")
        }

        func updateGameState(){
            if currentGame.incorrectMovesRemaining == 0 {
                totalLosses += 1
              } else if currentGame.word == currentGame.formattedWord {
                totalWins += 1
              } else {
                updateUI()
              }
          
        }
    


}

