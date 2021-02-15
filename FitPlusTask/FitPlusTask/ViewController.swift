//
//  ViewController.swift
//  FitPlusTask
//
//  Created by venkata rama kishore arimilli on 15/02/21.
//  Copyright © 2021 venkata rama kishore arimilli. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON

class ViewController: UIViewController {
    
    var userData:[User] = []
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var userTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        userTableView.register(UINib(nibName: "UserTableCell", bundle: nil), forCellReuseIdentifier: "UserTableCell")
        userTableView.dataSource = self
        userTableView.delegate = self
        userTableView.separatorStyle = .none
        self.navigationItem.title = "USERS"
        if let userCacheData = self.fetchUserResults(),userCacheData.count > 0 {
            userData = userCacheData
            self.userTableView.reloadData()
        } else {
            getUserData()
        }
        // Do any additional setup after loading the view.
    }
    
    private func getUserData() {
        activityIndicator.startAnimating()
        let userRequest = UserRequest()
        NetworkHandler.sendRequest(req: userRequest) { [weak self](success, data, error) in
            guard let self = self else {
                return
            }
            if success && error == nil, let responseData = data {
                let resultData = User.prepareUserData(jsonData: JSON(responseData)["data"])
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.userData = resultData
                    CoreDataManager.shared.saveContext()
                    self.userTableView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    private func fetchUserResults() -> [User]?{
        let fetchRequest:NSFetchRequest = User.fetchRequest()
        do {
            let results = try CoreDataManager.shared.managedContext.fetch(fetchRequest)
            return results
        } catch {
            print("\((error as NSError).userInfo)")
        }
        return nil
    }


}
extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let userCell = tableView.dequeueReusableCell(withIdentifier: "UserTableCell", for: indexPath) as? UserTableCell {
            userCell.configData(model: userData[indexPath.row])
            userCell.selectionStyle = .none
            return userCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailVC = userStoryboard.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else {
            return
        }
        detailVC.userObject = userData[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}
