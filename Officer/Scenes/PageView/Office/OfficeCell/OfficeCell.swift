//
//  OfficeCell.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import UIKit
import SDWebImage
import CoreData

protocol OfficeCellDelegate: AnyObject {
    func favoriteAdded(model: Office.Fetch.ViewModel.OfficeModel)
    func favoriteDeleted(model: Office.Fetch.ViewModel.OfficeModel)
}

class OfficeCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var nameLabel: CLTypingLabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var roomsLabel: UILabel!
    @IBOutlet weak var spaceLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var like: Bool = true
    
    weak var delegate: OfficeCellDelegate?
    
    var cellModel = Office.Fetch.ViewModel.OfficeModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    @IBAction func favoriteClicked(_ sender: UIButton) {
        
        let favoriteButton = sender as UIButton
        
        if like == false { //! yaptık çünkü User Defaultsa kaydolmamış olsa bile her türlü default olarak false gelecek,
            
            favoriteButton.setImage(UIImage(named: "disfav"), for: .normal)
            
            delegate?.favoriteDeleted(model: cellModel)
            
            like = true
        } else {
            
            favoriteButton.setImage(UIImage(named: "fav"), for: .normal)
            
            delegate?.favoriteAdded(model: cellModel)
            
            like = false
        }
    }
    
    
    //MARK: What cell Show
    func configureCell(viewModel: Office.Fetch.ViewModel.OfficeModel) {
        cellModel = viewModel
        nameLabel.text = viewModel.name
        addressLabel.text = viewModel.address
        capacityLabel.text = "Capacity: \(viewModel.capacity ?? "Not Found")"
        roomsLabel.text = "Rooms: \(viewModel.rooms ?? "Not Found")"
        spaceLabel.text = "Space: \(viewModel.space ?? "Not Found")"
        cellImageView.sd_setImage(with: URL(string: viewModel.image ?? "Not Found"))
        print(viewModel.latitude)
        print(viewModel.longitude)
        
    }
}
