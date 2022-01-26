//
//  BirthdayView.swift
//  TSD_lesson5
//
//  Created by Антон Головатый on 25.01.2022.
//

import UIKit

//MARK: - BirthdayView class declaration
@IBDesignable final class BirthdayView: UIView {

    //MARK: - Outlets
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var birthDayLabel: UILabel!
    @IBOutlet var daysLeftTillBirthdayLabel: UILabel!
    
    //MARK: - Private properties
    private var view: UIView!
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    //MARK: - Private methods
    private func loadFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let xib = UINib(nibName: "BirthdayView", bundle: bundle)
        guard let view = xib.instantiate(withOwner: self, options: nil).first as? UIView else {return UIView()}
        return view
    }
    
    private func setup() {
        
        self.view = loadFromXib()
        self.view.frame = bounds
        self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        photoImageView.layer.cornerRadius = photoImageView.frame.width / 2
        self.addSubview(view)
    }
    
    //MARK: - Public methods
    func configure(birthday: UserBirthdayProtocol) {
        
        nameLabel.text = birthday.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "dd MMMM"
        
        var birthDayLabelText = dateFormatter.string(from: birthday.birthDate)
        birthDayLabelText += ", will be of \(birthday.age + 1) age"
        birthDayLabel.text = birthDayLabelText
        
        daysLeftTillBirthdayLabel.text = String(birthday.daysBeforeBirthday) + " days"
    }
    
}
