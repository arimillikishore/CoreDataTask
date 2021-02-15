//
//  UserTableCell.swift
//  FitPlusTask
//
//  Created by venkata rama kishore arimilli on 15/02/21.
//  Copyright © 2021 venkata rama kishore arimilli. All rights reserved.
//

import UIKit
import CoreData

class UserTableCell: UITableViewCell {

    @IBOutlet weak var userName_Lbl: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var email_lbl: UILabel!
    @IBOutlet weak var uniqueId_Lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        avatarImage.image = UIImage(systemName: "person.circle")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configData(model:User) {
        userName_Lbl.text = model.name
        email_lbl.text = "Email : \(model.email)"
        uniqueId_Lbl.text = "ID : \(model.userId)"
        if let cacheImage = model.imageData {
            avatarImage.image = UIImage(data: cacheImage)
        } else {
            if let imageURL = URL(string: model.avatar) {
                avatarImage.downloaded(from: imageURL) { (success, image) in
                    if success, let img = image {
                        self.updateUserImageDate(image: img, obj: model)
                    }
                }
            } else {
                avatarImage.image = UIImage(systemName: "person.circle")
            }
        }
        
    }
    
    private func updateUserImageDate(image:UIImage,obj:User) {
        let fetchRequest: NSFetchRequest = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userId == \(obj.userId)")
        do {
            let res = try CoreDataManager.shared.persistentContainer.viewContext.fetch(fetchRequest)
            if let obj = res.first {
                obj.imageData = image.jpegData(compressionQuality: 0.8)
                CoreDataManager.shared.saveContext()
            }
        } catch {
            print("\((error as NSError).userInfo)")
        }
        
    }
    
}
