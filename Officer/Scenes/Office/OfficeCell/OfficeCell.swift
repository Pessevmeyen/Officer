//
//  OfficeCell.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import UIKit
import SDWebImage

class OfficeCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var roomsLabel: UILabel!
    @IBOutlet weak var spaceLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var like = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    @IBAction func favoriteClicked(_ sender: UIButton) {
        let button = sender as UIButton
        if like {
            button.setImage(UIImage(named: "custom.heart.fill"), for: .normal)
            like = false
        } else {
            button.setImage(UIImage(named: "custom.heart"), for: .normal)
            like = true
        }

        print("favorite clicked")
        
    }
    
    func configureCell(viewModel: Office.Fetch.ViewModel.OfficeModel) {
        nameLabel.text = viewModel.name ?? "Not Found"
        addressLabel.text = viewModel.address
        capacityLabel.text = "Capacity: \(viewModel.capacity ?? "Not Found")"
        roomsLabel.text = "Rooms: \(viewModel.rooms ?? "Not Found")"
        spaceLabel.text = "Space: \(viewModel.space ?? "Not Found")"
        cellImageView.sd_setImage(with: URL(string: viewModel.image ?? "Not Found"))
    }

    
}
