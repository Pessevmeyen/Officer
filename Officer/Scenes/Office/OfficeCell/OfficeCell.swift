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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(viewModel: Office.Fetch.ViewModel.OfficeModel) {
        nameLabel.text = viewModel.name
        addressLabel.text = viewModel.address
        capacityLabel.text = "Capacity: \(viewModel.capacity ?? "")"
        roomsLabel.text = "Rooms: \(viewModel.rooms ?? "")"
        spaceLabel.text = "Space: \(viewModel.space ?? "")"
        cellImageView.sd_setImage(with: URL(string: viewModel.image ?? ""))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
