//
//  DataLoadingViewController.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 24.01.2022.
//

import UIKit

class DataLoadingViewController: UIViewController {

    @IBOutlet var firstWhiteView: UIView!
    @IBOutlet var secondWhiteView: UIView!
    @IBOutlet var thirdWhiteView: UIView!
    
    let fromLoadingViewToTabBar = "fromLoadingViewToTabBar"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        
        firstWhiteView.layer.cornerRadius = 15
        secondWhiteView.layer.cornerRadius = 15
        thirdWhiteView.layer.cornerRadius = 15
        
        animateLoading(exitAfter: 1)
    }
    
    func animateLoading (exitAfter: Int, currentCount: Int = 1) {
        
        
        UIView.animate(withDuration: 0.7) { [weak self] in
            self?.thirdWhiteView.alpha = 0
            self?.firstWhiteView.alpha = 1
            self?.secondWhiteView.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.7) { [weak self] in
                self?.firstWhiteView.alpha = 0
                self?.secondWhiteView.alpha = 1
            } completion: { _ in
                UIView.animate(withDuration: 0.7) { [weak self] in
                    self?.secondWhiteView.alpha = 0
                    self?.thirdWhiteView.alpha = 1
                } completion: { [weak self] _ in
                    guard let self = self else { return }
                    if currentCount < exitAfter {
                        self.animateLoading(exitAfter: exitAfter,
                                             currentCount: currentCount + 1)
                    }
                    else {
                        UIView.animate(withDuration: 0.7) {
                            self.thirdWhiteView.alpha = 0
                        }
                        self.performSegue(withIdentifier: self.fromLoadingViewToTabBar,
                                           sender: nil)
                    }
                }
            }
        }
    }
}
