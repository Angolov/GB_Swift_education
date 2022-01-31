//
//  ColorGameViewController.swift
//  Right on target
//
//  Created by Антон Головатый on 20.12.2021.
//

import UIKit

class ColorGameViewController: UIViewController {

    var game: Game<ColorSecretValue>!
    
    @IBOutlet var colorLabel: UILabel!
    
    @IBOutlet var leftButton: UIButton!
    @IBOutlet var leftMiddleButton: UIButton!
    @IBOutlet var rightMiddleButton: UIButton!
    @IBOutlet var rightButon: UIButton!
    
    var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        game = (GameFactory.getColorGame() as! Game<ColorSecretValue>)
        buttons = [leftButton, leftMiddleButton, rightMiddleButton, rightButon]
        buttons.forEach {
            $0.setTitle("", for: .normal)
            
        }
        
        updateView()
    }
    
    // MARK: - View update
    private func updateView() {
        
        updateLabelWithSecretValue(String(game.currentSecretValue.value.getInHex()))
        updateButtonsWithSecret(game.currentSecretValue)
    }
    
    private func updateButtonsWithSecret(_ secretValue: ColorSecretValue) {
        
        let rightButtonTag = Array(1...4).randomElement()!
        
        for button in buttons {
            if button.tag == rightButtonTag {
                button.backgroundColor = secretValue.value.getInUIColor()
            } else {
                var randomColor = secretValue
                randomColor.setRandomValue()
                button.backgroundColor = randomColor.value.getInUIColor()
            }
        }
        
    }
    
    private func updateLabelWithSecretValue(_ newText: String) {
        colorLabel.text = "#\(newText)"
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
    
    @IBAction func colorButtonPressed(_ sender: UIButton) {
        
        var userColor = game.currentSecretValue
        userColor.value = Color(color: sender.backgroundColor!)
        
        game.calculateScore(with: userColor)
        
        if game.isGameEnded {
            showAlertWith(score: game.score)
            game.restartGame()
        } else {
            game.startNewRound()
        }
        updateView()
        
    }
}
