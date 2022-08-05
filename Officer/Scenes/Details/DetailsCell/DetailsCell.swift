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
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DetailsCell.imageTapped(gesture:)))
//        imageView.addGestureRecognizer(tapGesture)
//        imageView.isUserInteractionEnabled = true
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFulscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.addSubview(newImageView)
        self.inputViewController?.navigationController?.isNavigationBarHidden = true
        //self.inputViewController?.tabBarItem.isHidden = true
    }
    
    @objc func dismissFulscreenImage(_ sender: UITapGestureRecognizer) {
        self.inputViewController?.navigationController?.isNavigationBarHidden = false
        //self.inputAccessoryViewController?.tabBarItem.isHidden = false
        sender.view?.removeFromSuperview()
    }
//
//    @objc func imageTapped(gesture: UIGestureRecognizer) {
//        if (gesture.view as? UIImageView) != nil {
//            print("Image tapped")
//        }
//    }
    
    func configureCell(viewModel: Details.Fetch.ViewModel) {
        for singleImage in viewModel.images! { //Array halinde gelen image datalarını tek tek ekrana bastırmak için for kullandık. forEach veya map'da olurdu.
            imageView.sd_setImage(with: URL(string: singleImage)) //Array'i direk gösteremeyiz çünkü.
            print(singleImage)
        }
       
    }

}
