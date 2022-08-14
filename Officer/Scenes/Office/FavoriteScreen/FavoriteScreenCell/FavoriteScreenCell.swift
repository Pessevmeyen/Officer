//
//  FavoriteScreenCell.swift
//  Officer
//
//  Created by Furkan Eruçar on 14.08.2022.
//

import UIKit

class FavoriteScreenCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var roomsLabel: UILabel!
    @IBOutlet weak var spaceLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    


    
    func configureCell(viewModel: String) {
        
    }
}
