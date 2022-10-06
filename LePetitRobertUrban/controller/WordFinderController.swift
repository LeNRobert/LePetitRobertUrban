//
//  WordFinderController.swift
//  LePetitRobertUrban
//
//  Created by Nam-Robert Le on 06/10/2022.
//

import Foundation
import UIKit

class WordFinderController: UITableViewController {


    
    var definitions: [Definition] = [Definition]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Liste de definitions"
        refreshDefinitionList()
    }
      
    func refreshDefinitionList() {
        self.definitions.removeAll()
        let urbanAPI = UrbanAPI()
        urbanAPI.getRandomWord().done { word in
            self.definitions = word.definitions
            self.tableView.reloadData()
        }
    }
      
      
      
    override func tableView( tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "DefinitionsCell")
          
        cell.textLabel?.text = self.cartes[indexPath.row].name
          
        return cell
    }
      
    override func tableView( tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return cartes.count
    }
      
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
      
      
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          self.performSegue(withIdentifier: "toCarteClassDescription", sender: cartes[indexPath.row])
    }
      
      
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCarteClassDescription" {
              
            let carte = sender as? Carte
              
            if let viewControllerDestination = segue.destination as? CarteDesciptionClassController {
                viewControllerDestination.carte = carte
            }
              
        }
    }
    
    
}
