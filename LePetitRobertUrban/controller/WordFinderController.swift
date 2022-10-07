//
//  WordFinderController.swift
//  LePetitRobertUrban
//
//  Created by Nam-Robert Le on 06/10/2022.
//

import UIKit
import Alamofire
import SwiftyJSON
import Foundation

class DefinitionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var definitionLabel: UILabel!
    
    
    @IBOutlet weak var exempleLabel: UILabel!
}



class WordFinderController: UITableViewController {
    
    var wordToFound = "404"

    var definitions: [Definition] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshDefList()
    }
    
    func refreshDefList() {
        self.definitions.removeAll()
        UrbanAPI.getWord(searchWord: wordToFound).done { word in
            self.definitions = word.definitions
            self.title = self.definitions[0].word
            self.tableView.reloadData()
            
            for i in 0...self.definitions.count-1{
                print(self.definitions[i].definition)
            }
        }
    }
      
      
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefinitionCell", for: indexPath) as! DefinitionTableViewCell
        
        let def = self.definitions[indexPath.row]
            
        cell.definitionLabel.text = def.definition
        cell.exempleLabel.text = def.exemple
          
        return cell
    }
      
    override func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return definitions.count
    }
      
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
      
    /*
     // a enlever ou remettre
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          self.performSegue(withIdentifier: "toDefinitionClassDescription", sender: definitions[indexPath.row])
    }
    */
    
    
    /*
    // a enlever ou remettre
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDefinitionClassDescription" {
              
            let definition = sender as? Definition
              
            if let viewControllerDestination = segue.destination as? DefinitionDesciptionClassController {
                viewControllerDestination.definition = definition
            }
              
        }
    }
    */
    
}
