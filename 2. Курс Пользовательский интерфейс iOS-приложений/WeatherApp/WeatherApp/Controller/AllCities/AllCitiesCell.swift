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
    @IBOutlet weak var cityNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
