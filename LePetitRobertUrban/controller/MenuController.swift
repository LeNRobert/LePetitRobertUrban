//
//  MenuController.swift
//  LePetitRobertUrban
//
//  Created by Nam-Robert Le on 01/10/2022.
//

import UIKit

class MenuController: UIViewController, UISearchBarDelegate {
    var wordToFound = "Bonjour"
    
    var hasLoadedOnce = true
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchWord = ""
    
    @IBOutlet weak var wordNameLabel: UILabel!
    
    @IBOutlet weak var definitionLabel: UILabel!
    
    @IBOutlet weak var exempleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchBar.delegate = self
        print(hasLoadedOnce)
        if !hasLoadedOnce{
            Task {
                await UrbanAPI.getRandomWord().done(on: .main, { word in
                    self.wordToFound = word
                })
            }
        }
        else{
            hasLoadedOnce = false
            print(hasLoadedOnce)

        }
        Task {
            await UrbanAPI.getWord(searchWord: wordToFound).done { word in
                self.definitionLabel.text = word.definitions[0].definition
                self.wordNameLabel.text = word.definitions[0].word
                self.exempleLabel.text = word.definitions[0].exemple
            }
        }
        
    }
    
    

    @IBAction func randomButtonAction(_ sender: Any) {
        Task {
            await UrbanAPI.getRandomWord().done(on: .main, { word in
                self.wordToFound = word
            })
        }
        self.performSegue(withIdentifier: "toNavigationController", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        Task {
            if segue.identifier == "toNavigationController" {
                    
                if let navController = segue.destination as? UINavigationController {
                    if let controller = navController.viewControllers[0] as? WordFinderController {
                        controller.wordToFound = wordToFound
                        controller.ready = true
                    }
                }
            }
        }

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        self.searchWord = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchWord != ""{
            print(searchWord)
            wordToFound = self.searchWord
            
            self.performSegue(withIdentifier: "toNavigationController", sender: nil)
        }

    }
    
}
