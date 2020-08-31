//
//  ViewController.swift
//  FriendFace
//
//  Created by Guru Ranganathan on 8/30/20.
//  Copyright © 2020 Guru. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchResultsUpdating {
    
    var friends = [Friend]()
    
    var filteredFriends = [Friend]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchResultsUpdater = self
        navigationItem.searchController = search
        
        
        DispatchQueue.global().async {
            
            do {
                
                let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
                
                let data = try Data(contentsOf: url)
                
                let decoder = JSONDecoder()
                
                decoder.dateDecodingStrategy = .iso8601
                
                let friendsDecoded = try decoder.decode([Friend].self, from: data)
                
                self.friends = friendsDecoded
                self.filteredFriends = friendsDecoded
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                
            }catch {
                print("error: \(error.localizedDescription)")
            }
            
        }
            
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let friend = filteredFriends[indexPath.row]
        
        cell.textLabel?.text = friend.name
        
        cell.detailTextLabel?.text = friend.friends.map{$0.name}.joined(separator: ",")
        
        return cell
        
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let query = searchController.searchBar.text, query.count > 0 {
            
            filteredFriends = friends.filter {
                $0.name.contains(query) ||
                    $0.company.contains(query)
            }
        }else {
            filteredFriends  = friends
        }
        
        tableView.reloadData()
    }


}

