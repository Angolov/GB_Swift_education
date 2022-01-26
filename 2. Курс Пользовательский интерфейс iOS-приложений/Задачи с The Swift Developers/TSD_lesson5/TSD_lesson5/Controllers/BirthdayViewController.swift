//
//  BirthdayViewController.swift
//  TSD_lesson5
//
//  Created by Антон Головатый on 25.01.2022.
//

import UIKit

//MARK: - BirthdayView class declaration
final class BirthdayViewController: UIViewController {

    //MARK: - Public properties
    let birthDayViewHeight = 90
    var currentPositionY = 100
    var fromBirthdayViewToAddInfoView = "fromBirthdayViewToAddInfoView"
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViewWith(userBirthday: UserBirthday(name: "Jeremy",
                                                  birthDate: "10 March 1997",
                                                  photo: UIImage()))
        createViewWith(userBirthday: UserBirthday(name: "Maria Lul",
                                                  birthDate: "30 March 2002",
                                                  photo: UIImage()))
        createViewWith(userBirthday: UserBirthday(name: "Jony Stark",
                                                  birthDate: "20 April 1997",
                                                  photo: UIImage()))
    }

    //MARK: - Private properties
    private func createViewWith(userBirthday: UserBirthdayProtocol) {

        let newView = BirthdayView(frame: CGRect(x: 0,
                                                 y: currentPositionY,
                                                 width: Int(self.view.frame.width),
                                                 height: birthDayViewHeight))
        newView.configure(birthday: userBirthday)
        self.view.addSubview(newView)
        currentPositionY += birthDayViewHeight
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == fromBirthdayViewToAddInfoView,
              let destination = segue.destination as? AddInfoViewController else { return }
        
        destination.completion = { [weak self] newUser in
            guard let self = self else { return }
            self.createViewWith(userBirthday: newUser)
        }
    }
}
