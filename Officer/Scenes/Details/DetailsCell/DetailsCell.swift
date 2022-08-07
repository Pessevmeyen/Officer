//
//  DetailsCell.swift
//  Officer
//
//  Created by Furkan Eruçar on 4.08.2022.
//

import UIKit
import SDWebImage

class DetailsCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

    func configureCell(viewModel: Details.Fetch.ViewModel) {
        for singleImage in viewModel.images! { //Array halinde gelen image datalarını tek tek ekrana bastırmak için for kullandık. forEach veya map'da olurdu.
            //imageViewButton.sd_setImage(with: URL(string: singleImage), for: .normal)
            imageView.sd_setImage(with: URL(string: singleImage)) //Array'i direk gösteremeyiz çünkü.
            print(singleImage)
        }
       
    }
    

}
