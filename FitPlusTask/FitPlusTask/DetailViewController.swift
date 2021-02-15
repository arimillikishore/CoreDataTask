//
//  DetailViewController.swift
//  FitPlusTask
//
//  Created by venkata rama kishore arimilli on 15/02/21.
//  Copyright © 2021 venkata rama kishore arimilli. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var userObject:User!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImage.image = UIImage(systemName: "person.circle")
        self.navigationItem.title = "User Details"
        if let cacheImage = userObject.imageData {
            userImage.image = UIImage(data: cacheImage)
        } else {
            if let imageURL = URL(string: userObject.avatar) {
                userImage.downloaded(from: imageURL) { (success, image) in
                }
            } else {
                userImage.image = UIImage(systemName: "person.circle")
            }
        }
        nameLabel.text = userObject.name
        emailLabel.text = "Email : \(userObject.email)"
        idLabel.text = "ID : \(userObject.userId)"
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
