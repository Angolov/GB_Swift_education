//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

// MARK: - GameViewController class declaration

final class GameViewController: UIViewController {

    // MARK: - UI elements
    
    lazy var gameboardView: GameboardView = {
        let view = GameboardView()
        view.backgroundColor = .white
        return view
    }()
    lazy var firstPlayerTurnLabel: UILabel = {
        let label = UILabel()
        label.text = "1st player"
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    lazy var secondPlayerTurnLabel: UILabel = {
        let label = UILabel()
        label.text = "2nd player"
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    lazy var winnerLabel: UILabel = {
        let label = UILabel()
        label.text = "Winner is 1st player!"
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    lazy var restartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Restart", for: .normal)
        button.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    private lazy var referee = Referee(gameboard: self.gameboard)
    private let gameboard = Gameboard()
    private var currentState: GameState! {
        didSet {
            self.currentState.begin()
        }
    }
    
    var gameMode: GameMode!
    
    // MARK: - VC lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        goToFirstState()

        gameboardView.onSelectPosition = { [weak self] position in
            guard let strongSelf = self else { return }
            strongSelf.currentState.addMark(at: position)
        
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                if strongSelf.currentState.isCompleted {
                    strongSelf.goToNextState()
                    timer.invalidate()
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let width = self.view.width / 2 - 20
        let height: CGFloat = 52
        let inset: CGFloat = 10
        firstPlayerTurnLabel.frame = CGRect(x: inset,
                                            y: inset * 5,
                                            width: width,
                                            height: height)
        secondPlayerTurnLabel.frame = CGRect(x: self.view.center.x + inset,
                                             y: inset * 5,
                                             width: width,
                                             height: height)
        winnerLabel.frame = CGRect(x: self.view.center.x - width / 2,
                                   y: firstPlayerTurnLabel.bottom + inset,
                                   width: width,
                                   height: height)
        restartButton.frame = CGRect(x: self.view.center.x - width / 2,
                                     y: self.view.bottom - height - inset * 2,
                                     width: width,
                                     height: height)
        
        let viewWidthWithInsets = self.view.width - inset * 2
        let viewEmtySpaceHeight = restartButton.top - winnerLabel.bottom - inset * 2
        let size = viewWidthWithInsets < viewEmtySpaceHeight ? viewWidthWithInsets : viewEmtySpaceHeight
        gameboardView.frame = CGRect(x: inset,
                                     y: winnerLabel.bottom + (viewEmtySpaceHeight - size) / 2,
                                     width: size,
                                     height: size)
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(firstPlayerTurnLabel)
        view.addSubview(secondPlayerTurnLabel)
        view.addSubview(winnerLabel)
        view.addSubview(gameboardView)
        view.addSubview(restartButton)
    }
    
    private func goToFirstState() {
        let player = Player.first
        
        if gameMode == .blindGame {
            currentState = BlindInputState(player: player,
                                           markViewPrototype: player.markViewPrototype,
                                           gameViewController: self,
                                           gameboard: gameboard,
                                           gameboardView: gameboardView)
            
        } else {
            currentState = PlayerInputState(player: player,
                                            markViewPrototype: player.markViewPrototype,
                                            gameViewController: self,
                                            gameboard: gameboard,
                                            gameboardView: gameboardView)
        }
    }
    
    private func goToNextState() {
        if gameMode != .blindGame {
            checkGameConditions()
        }
        
        if let computerInputState = currentState as? ComputerInputState {
            let player = computerInputState.player.next
            currentState = PlayerInputState(player: player,
                                            markViewPrototype: player.markViewPrototype,
                                            gameViewController: self,
                                            gameboard: gameboard,
                                            gameboardView: gameboardView)
            
        } else if let playerInputState = currentState as? PlayerInputState {
            switch gameMode {
            case .multiPlayer:
                let player = playerInputState.player.next
                currentState = PlayerInputState(player: player,
                                                markViewPrototype: player.markViewPrototype,
                                                gameViewController: self,
                                                gameboard: gameboard,
                                                gameboardView: gameboardView)
            case .singlePlayer:
                goToComputerState()
            default:
                return
            }
            
        } else if let playerInputState = currentState as? BlindInputState {
            if playerInputState.player == .second {
                goToMovesExecutionState()
                
            } else {
                let player = playerInputState.player.next
                currentState = BlindInputState(player: player,
                                               markViewPrototype: player.markViewPrototype,
                                               gameViewController: self,
                                               gameboard: gameboard,
                                               gameboardView: gameboardView)
            }
        }
    }
    
    private func goToComputerState() {
        let computer = Player.computer
        currentState = ComputerInputState(player: computer,
                                          markViewPrototype: computer.markViewPrototype,
                                          gameViewController: self,
                                          gameboard: gameboard,
                                          gameboardView: gameboardView)
        if currentState.isCompleted {
            goToNextState()
        }
    }
    
    private func goToMovesExecutionState() {
        currentState = MovesExecutionState(gameViewController: self)
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
            guard let strongSelf = self else { return }
            if strongSelf.currentState.isCompleted {
                strongSelf.checkGameConditions()
                timer.invalidate()
            }
        }
    }
    
    private func checkGameConditions() {
        if let winner = referee.determineWinner() {
            currentState = GameEndedState(winner: winner, gameViewController: self)
            return
        }
        if referee.determineDraw() {
            currentState = GameEndedState(winner: nil, gameViewController: self)
            return
        }
    }
    
    // MARK: - Actions
    
    @objc func restartButtonTapped() {
        gameboard.clear()
        gameboardView.clear()
        goToFirstState()
        Log(.restartGame)
    }
}

