//
//  FullScreenCell.swift
//  Officer
//
//  Created by Furkan Eruçar on 9.08.2022.
//

import UIKit

class FullScreenCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    func configureCell(image: String) {
        
        imageView.image = UIImage(named: image)
        
        pageControl.currentPage = 3
        
//        pageControl.numberOfPages = FullScreenInteractor().selectedIndex ?? 0
        
        
        
//        for singleImage in viewModel.images { //Array halinde gelen image datalarını tek tek ekrana bastırmak için for kullandık. forEach veya map'da olurdu.
//            //imageViewButton.sd_setImage(with: URL(string: singleImage), for: .normal)
//            imageView.image = UIImage(named: viewModel.images[singleImage])
//
//            print(singleImage)
//        }
       
    }
    
}
