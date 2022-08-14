//
//  OfficeCell.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import UIKit
import SDWebImage
import CoreData

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
    
    //MARK: TODO: İmage aktarılacak. Kullanıcı tekrar uygulamaya girdiğinde favoriye eklemişse buton yanıyor olacak, eklememişse yanmıyor olacak. Yoksa ilk uygulamaya girdiğinde hep buton kapalı gözükecek.
    @IBAction func favoriteClicked(_ sender: UIButton) {
        
        let button = sender as UIButton
        
        if like {
            button.setImage(UIImage(named: "custom.heart.fill"), for: .normal)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let offices = NSEntityDescription.insertNewObject(forEntityName: "Offices", into: context)
            
            offices.setValue(UUID(), forKey: "uuid")
            offices.setValue(nameLabel.text, forKey: "name")
            offices.setValue(addressLabel.text, forKey: "address")
            offices.setValue(capacityLabel.text, forKey: "capacity")
            offices.setValue(roomsLabel.text, forKey: "rooms")
            offices.setValue(spaceLabel.text, forKey: "space")
            //offices.setValue(cellImageView, forKey: "image") ????
            
            
            do {
                try context.save()
                print("saved")
            } catch {
                print("saving error!")
            }
            
            NotificationCenter.default.post(name: NSNotification.Name("veriGirildi"), object: nil)
            
            like = false
        } else {
            
            button.setImage(UIImage(named: "custom.heart"), for: .normal)
            
            //Core Datadan silmeden önce verileri çağırmamız gerek.
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Offices")
            //let uuidString =
            
            //fetchRequest.predicate = NSPredicate(format: "id = %@", uuidString)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let uuid = result.value(forKey: "uuid") as? UUID {
                            if uuid == uuid {
                                print("uuid şu \(uuid)")
                                context.delete(result)
                                print("silindi")
                                
                                do {
                                    try context.save()
                                } catch {
                                    print("save edilmedi")
                                }
                                
                                break
                                
                            }
                        }
                    }
                }
            } catch {
                print("hata")
            }
            
            
            like = true
        }
        
        
        
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
