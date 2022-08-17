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
    


    
    func configureCell(name: String, address: String, image: String, capacity: String, rooms: String, space: String) {
        nameLabel.text = name
        addressLabel.text = address
        capacityLabel.text = "Capacity: \(capacity)"
        roomsLabel.text = "Rooms: \(rooms)"
        spaceLabel.text = "Space: \(space)"
        cellImageView.sd_setImage(with: URL(string: image))
    }
}
