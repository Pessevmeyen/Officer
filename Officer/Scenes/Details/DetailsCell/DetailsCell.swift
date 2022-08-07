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
    
        let pictureTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        imageView.addGestureRecognizer(pictureTap)
        imageView.isUserInteractionEnabled = true
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageViewer = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        //self.view.addSubview(newImageView)


        print("image tapped")
    }

    @objc func dissmissFullScreenImage(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
    
    
    
    func configureCell(viewModel: Details.Fetch.ViewModel) {
        for singleImage in viewModel.images! { //Array halinde gelen image datalarını tek tek ekrana bastırmak için for kullandık. forEach veya map'da olurdu.
            //imageViewButton.sd_setImage(with: URL(string: singleImage), for: .normal)
            imageView.sd_setImage(with: URL(string: singleImage)) //Array'i direk gösteremeyiz çünkü.
            print(singleImage)
        }
       
    }
    

}
