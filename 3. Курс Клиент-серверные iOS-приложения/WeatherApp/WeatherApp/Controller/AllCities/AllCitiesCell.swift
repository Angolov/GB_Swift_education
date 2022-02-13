//
//  AllCitiesCell.swift
//  WeatherApp
//
//  Created by Антон Головатый on 12.02.2022.
//

import UIKit

//MARK: - AllCitiesCell class declaration
final class AllCitiesCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var cityNameLabel: UILabel! {
        didSet {
            self.cityNameLabel.textColor = UIColor.white
        }
    }
    
    @IBOutlet var cityEmblemImageView: UIImageView! {
        didSet {
            self.cityEmblemImageView.backgroundColor = UIColor.white
            self.cityEmblemImageView.layer.borderColor = UIColor.white.cgColor
            self.cityEmblemImageView.layer.borderWidth = 2
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(city: String, emblem: UIImage) {
        self.cityNameLabel.text = city
        self.cityEmblemImageView.image = emblem
        self.backgroundColor = UIColor.black
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cityNameLabel.text = nil
        self.cityEmblemImageView.image = nil
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        cityEmblemImageView.clipsToBounds = true
        cityEmblemImageView.layer.cornerRadius = cityEmblemImageView.frame.width / 2
    }

}
