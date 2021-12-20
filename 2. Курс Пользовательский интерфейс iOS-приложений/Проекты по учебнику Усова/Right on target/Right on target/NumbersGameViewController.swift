//
//  ViewController.swift
//  Right on target
//
//  Created by Антон Головатый on 15.12.2021.
//

import UIKit

class NumbersGameViewController: UIViewController {
    
    var game: Game<NumericSecretValue>!
    
    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game = (GameFactory.getNumericGame() as! Game<NumericSecretValue>)
        updateLabelWithSecretNumber(String(game.currentSecretValue.value))
    }

    // MARK: - View update
    private func updateLabelWithSecretNumber(_ newText: String) {
        label.text = newText
    }
    
    
    private func showAlertWith(score: Int) {
        
        let alert = UIAlertController(
            title: "Игра окончена",
            message: "Вы заработали \(score) очков",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Начать заново",
                                      style: .default,
                                      handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - View-Model interaction
    @IBAction func checkNumber() {
        
        var userValue = game.currentSecretValue
        userValue.value = Int(slider.value)
        
        print("checkNumber values \(game.currentSecretValue.value) \(userValue.value)")
        game.calculateScore(with: userValue)

        if game.isGameEnded {
            showAlertWith(score: game.score)
            game.restartGame()
        } else {
            game.startNewRound()
        }

        updateLabelWithSecretNumber(String(game.currentSecretValue.value))
    }
    

}

