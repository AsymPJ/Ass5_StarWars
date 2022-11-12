//
//  StarWTableViewCell.swift
//  Ass5_StarWars
//
//  Created by user228139 on 11/11/22.
//

import UIKit

class StarWTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameCharacter: UILabel!
    
    @IBOutlet weak var hairColorChar: UILabel!
    
    @IBOutlet weak var eyeColorChar: UILabel!

    @IBOutlet weak var homeChar: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
