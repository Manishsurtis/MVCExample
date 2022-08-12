//
//  ViewController.swift
//  JsonExample
//
//  Created by Manish on 10/08/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    var userData = [User]()
    var userManager = UserManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    func loadData(){
        userManager.delegate = self
        userManager.fetchUserDetails()
    }
}

extension ViewController : UserManagerDelegate{
    func didUserDetails(userList: [User]) {
        self.userData = userList
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "Cell") as! UserTableCell
        cell.lblName.text = userData[indexPath.row].title
        return cell
    }
}
