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



class WordFinderController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var shuffleImage: UIImageView!
    
    
    var wordToFound = ""

    var definitions: [Definition] = []
    
    var searchBarText = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        shuffleImage.isUserInteractionEnabled = true
        shuffleImage.addGestureRecognizer(tapGestureRecognizer)
        

        
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            if self.wordToFound != "" {
                timer.invalidate()
            }
        }
        self.refreshDefList()
    }
    
    @IBAction func tapDefinitionLabel(gesture: UITapGestureRecognizer) {
        
    }
    

    
    
    
    func refreshDefList(){
        self.definitions.removeAll()
        Task {
            await UrbanAPI.getWord(searchWord: wordToFound).done { word in
                self.definitions = word.definitions
                self.title = self.definitions[0].word
                self.tableView.reloadData()
                
                for i in 0...self.definitions.count-1{
                    print(self.definitions[i].definition)
                }
            }
        }
    }
      
      
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefinitionCell", for: indexPath) as! DefinitionTableViewCell
        
        let tapDef = UITapGestureRecognizer(target: self, action: #selector(self.tapDefinitionLabel))
        cell.definitionLabel.isUserInteractionEnabled = true
        cell.definitionLabel.addGestureRecognizer(tapDef)
            
            let def = self.definitions[indexPath.row]
                
            cell.definitionLabel.text = def.definition.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
            cell.exempleLabel.text = def.exemple.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
              
            return cell
    }
      
    override func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return definitions.count
    }
      
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
      
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        searchBarText = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBarText != ""{
            print(searchBarText)
            wordToFound = searchBarText
            
            self.refreshDefList()
        }
    }
    
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView

        // Your action
        Task {
            await UrbanAPI.getRandomWord().done(on: .main, { word in
                self.wordToFound = word
            })
        }
        self.refreshDefList()
    }
}
