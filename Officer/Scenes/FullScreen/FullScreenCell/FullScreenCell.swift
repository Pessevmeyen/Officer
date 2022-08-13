//
//  FullScreenCell.swift
//  Officer
//
//  Created by Furkan Eruçar on 9.08.2022.
//

import UIKit
import SDWebImage

class FullScreenCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configureCell(image: String) {
        
        imageView.sd_setImage(with: URL(string: image))
     
    }
    
}
