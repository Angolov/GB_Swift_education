//
//  MyCitiesCell.swift
//  WeatherApp
//
//  Created by Антон Головатый on 12.02.2022.
//

import UIKit

//MARK: - MyCitiesCell class declaration
final class MyCitiesCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var cityNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
