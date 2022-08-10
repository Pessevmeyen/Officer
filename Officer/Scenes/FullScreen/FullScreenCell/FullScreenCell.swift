//
//  FullScreenCell.swift
//  Officer
//
//  Created by Furkan Eruçar on 9.08.2022.
//

import UIKit

class FullScreenCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configureCell(image: String) {
        
        imageView.image = UIImage(named: image)
       
    }
    
}
