//
//  ViewController.swift
//  Random User Generator
//
//  Created by Macbook Air on 22.01.2022.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var users: [UserModel] = []
    
    private var currentPage = 1
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Set up a back button
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Back", style: .plain, target: nil, action: nil)
        
        // MARK: Created a get request
        let _ = networkManager.getUsers(page: currentPage, count: 20) { [weak self] listOfUsers in
            self?.users += listOfUsers
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        // MARK: Register a custom cell
        let nib = UINib(nibName: "UserCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "UserCell")
        
    }
}

// MARK: Extensions: DataSource, Delegate

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell else {
            return UITableViewCell() }
        cell.setupWith(user: users[indexPath.row])
        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let DetailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else { return }
        navigationController?.pushViewController(DetailsViewController, animated: true)
    }
}

