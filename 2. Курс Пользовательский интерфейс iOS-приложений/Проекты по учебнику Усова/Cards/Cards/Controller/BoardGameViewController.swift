//
//  BoardGameViewController.swift
//  Cards
//
//  Created by Антон Головатый on 10.02.2022.
//

import UIKit

class BoardGameViewController: UIViewController {

    var cardsPairsCounts = 8
    var cardViews = [UIView]()
    
    private var score = 100
    private var stepsDone = 0
    private var cardsLeftCount = 8
    private var flippedCards = [UIView]()
    
    private var cardSize: CGSize {
        CGSize(width: 80, height: 120)
    }
    
    private var cardMaxXCoordinate: Int {
        Int(boardGameView.frame.width - cardSize.width)
    }
    
    private var cardMaxYCoordinate: Int {
        Int(boardGameView.frame.height - cardSize.height)
    }

    
    lazy var game: Game = getNewGame()
    
    lazy var startButtonView = getStartButtonView()
    lazy var scoreLabelView = getScoreLabelView()
    lazy var flipButtonView = getFlipButtonView()
    lazy var boardGameView = getBoardGameView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        view.addSubview(startButtonView)
        view.addSubview(scoreLabelView)
        view.addSubview(flipButtonView)
        view.addSubview(boardGameView)
    }
    
    private func getNewGame() -> Game {
        let game = Game()
        game.cardsCount = self.cardsPairsCounts
        game.generateCards()
        return game
    }
    
    private func getStartButtonView() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        button.center.x = view.center.x
        let window = UIApplication.shared.windows[0]
        let topPadding = window.safeAreaInsets.top
        button.frame.origin.y = topPadding
        
        button.setTitle("Начать игру", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 10
        
        button.addTarget(nil, action: #selector(startGame(_:)), for: .touchUpInside)
        
        return button
    }
    
    private func getScoreLabelView() -> UILabel {
        let margin: CGFloat = 10
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        label.frame.origin.x = margin
        let window = UIApplication.shared.windows[0]
        let topPadding = window.safeAreaInsets.top
        label.frame.origin.y = topPadding
        
        label.text = "Your score: \(score)\nSteps done: \(stepsDone)"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 2
        
        return label
    }
    
    private func getFlipButtonView() -> UIButton {
        let margin: CGFloat = 10
        let buttonOriginX = startButtonView.frame.origin.x + startButtonView.frame.width + margin
        let buttonWidth = self.view.frame.maxX - buttonOriginX - margin
        
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: buttonWidth, height: 50))
        button.frame.origin.x = buttonOriginX
        let window = UIApplication.shared.windows[0]
        let topPadding = window.safeAreaInsets.top
        button.frame.origin.y = topPadding
        
        button.setAttributedTitle(NSAttributedString(string: "Перевернуть",
                                                     attributes: [.font : UIFont.systemFont(ofSize: 16)]),
                                  for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 10
        
        return button
    }
    
    private func getBoardGameView() -> UIView {
        
        let margin: CGFloat = 10
        let boardView = UIView()
        
        boardView.frame.origin.x = margin
        let window = UIApplication.shared.windows[0]
        let topPadding = window.safeAreaInsets.top
        boardView.frame.origin.y = topPadding + startButtonView.frame.height + margin
        boardView.frame.size.width = UIScreen.main.bounds.width - margin * 2
        let bottomPadding = window.safeAreaInsets.bottom
        boardView.frame.size.height = UIScreen.main.bounds.height - boardView.frame.origin.y - margin - bottomPadding
        
        boardView.layer.cornerRadius = 5
        boardView.clipsToBounds = true
        boardView.backgroundColor = UIColor(red: 0.1, green: 0.9, blue: 0.1, alpha: 0.3)
        
        return boardView
    }
    
    private func getCardsBy(modelData: [Card]) -> [UIView] {
        var cardViews = [UIView]()
        let cardViewFactory = CardViewFactory()
        for (index, modelCard) in modelData.enumerated() {
            let cardOne = cardViewFactory.get(modelCard.type,
                                              withSize: cardSize,
                                              andColor: modelCard.color)
            cardOne.tag = index
            cardViews.append(cardOne)
            let cardTwo = cardViewFactory.get(modelCard.type,
                                              withSize: cardSize,
                                              andColor: modelCard.color)
            cardTwo.tag = index
            cardViews.append(cardTwo)
        }
        
        for card in cardViews {
            (card as! FlippableView).flipCompletionHandler = { flippedCard in
                flippedCard.superview?.bringSubviewToFront(flippedCard)
            }
        }
        
        for card in cardViews {
            (card as! FlippableView).flipCompletionHandler = { [weak self] flippedCard in
                guard let self = self else { return }
                
                flippedCard.superview?.bringSubviewToFront(flippedCard)
                
                if flippedCard.isFlipped {
                    self.flippedCards.append(flippedCard)
                    
                } else {
                    if let cardIndex = self.flippedCards.firstIndex(of: flippedCard) {
                        self.flippedCards.remove(at: cardIndex)
                    }
                }
                
                if self.flippedCards.count == 2 {
                    let firstCard = self.game.cards[self.flippedCards.first!.tag]
                    let secondCard = self.game.cards[self.flippedCards.last!.tag]
                    
                    if self.game.checkCards(firstCard, secondCard) {
                        UIView.animate(withDuration: 0.3) {
                            self.flippedCards.first!.layer.opacity = 0
                            self.flippedCards.last!.layer.opacity = 0
                        } completion: { _ in
                            self.flippedCards.first!.removeFromSuperview()
                            self.flippedCards.last!.removeFromSuperview()
                            self.flippedCards = []
                        }
                        self.cardsLeftCount -= 1

                    } else {
                        for card in self.flippedCards {
                            (card as! FlippableView).flip()
                        }
                    }
                }
                
                self.score -= 1
                self.stepsDone += 1
                self.updateView()
                
                if self.cardsLeftCount == 0 {
                    let alert = UIAlertController(title: "Game Over", message: "Your current score is \(self.score) points.\nDo you want to start a new game?", preferredStyle: .alert)
                    let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
                        self.startGame(UIButton())
                    }
                    let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
                    alert.addAction(yesAction)
                    alert.addAction(noAction)
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        return cardViews
    }
    
    private func placeCardsOnBoard(_ cards: [UIView]) {
        for card in cardViews {
            card.removeFromSuperview()
        }
        cardViews = cards
        
        for card in cardViews {
            let randomXCoordinate = Int.random(in: 0...cardMaxXCoordinate)
            let randomYCoordinate = Int.random(in: 0...cardMaxYCoordinate)
            card.frame.origin = CGPoint(x: randomXCoordinate, y: randomYCoordinate)
            boardGameView.addSubview(card)
        }
    }
    
    private func updateView() {
        scoreLabelView.text = "Your score: \(score)\nSteps done: \(stepsDone)"
    }
    
    @objc func startGame(_ sender: UIButton) {
        game = getNewGame()
        let cards = getCardsBy(modelData: game.cards)
        placeCardsOnBoard(cards)
        cardsLeftCount = cardsPairsCounts
        score = 100
        stepsDone = 0
        updateView()
    }
}
