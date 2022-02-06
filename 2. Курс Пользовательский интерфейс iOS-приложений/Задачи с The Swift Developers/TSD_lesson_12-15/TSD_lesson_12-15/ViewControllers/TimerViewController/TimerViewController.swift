//
//  TimerViewController.swift
//  TSD_lesson_12-15
//
//  Created by Антон Головатый on 05.02.2022.
//

import UIKit

//MARK: - TimerViewController class declaration
final class TimerViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    //MARK: - Private properties
    private let startColor = #colorLiteral(red: 0.004308367614, green: 0.56444484, blue: 0.2140515149, alpha: 1)
    private let pauseColor = #colorLiteral(red: 0.8873060346, green: 0.002745732432, blue: 0.1067414954, alpha: 1)
    private lazy var startText: NSAttributedString = {
        return NSAttributedString(string: "Start",
                                  attributes: [.font : UIFont.systemFont(ofSize: 25, weight: .bold)])
    }()
    private lazy var pauseText: NSAttributedString = {
        return NSAttributedString(string: "Pause",
                                  attributes: [.font : UIFont.systemFont(ofSize: 25, weight: .bold)])
    }()
    private var timer = Timer()
    private var count = 0
    private var isTimerRunning = false
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - Private methods
    private func setupView() {
        
        timerLabel.layer.shadowColor = UIColor.black.cgColor
        timerLabel.layer.shadowRadius = 10
        timerLabel.layer.shadowOffset = CGSize(width: 5, height: 5)
        timerLabel.layer.shadowOpacity = 0.7
        
        startButton.backgroundColor = startColor
        startButton.layer.cornerRadius = 15
        startButton.layer.shadowColor = UIColor.darkGray.cgColor
        startButton.layer.shadowRadius = 10
        startButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        startButton.layer.shadowOpacity = 0.7
        
        resetButton.layer.cornerRadius = 15
        resetButton.layer.shadowColor = UIColor.darkGray.cgColor
        resetButton.layer.shadowRadius = 10
        resetButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        resetButton.layer.shadowOpacity = 0.7
    }
    
    private func makeTimeString(from counter: Int) -> String {
        
        var timeString = ""
        let hours = counter / 3600
        let minutes = (counter % 3600) / 60
        let seconds = (counter % 3600) % 60
        
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        
        return timeString
    }
    
    //MARK: - Actions
    @IBAction func startButtonPressed(_ sender: UIButton) {
        
        if isTimerRunning {
            startButton.backgroundColor = startColor
            startButton.setAttributedTitle(startText, for: .normal)
            timer.invalidate()
            
        } else {
            startButton.backgroundColor = pauseColor
            startButton.setAttributedTitle(pauseText, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(timerCounter),
                                         userInfo: nil,
                                         repeats: true)
        }
        isTimerRunning = !isTimerRunning
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        timer.invalidate()
        startButton.backgroundColor = startColor
        startButton.setAttributedTitle(startText, for: .normal)
        count = 0
        timerLabel.text = makeTimeString(from: 0)
    }
    
    @objc func timerCounter() {
        count += 1
        timerLabel.text = makeTimeString(from: count)
    }
    
}
