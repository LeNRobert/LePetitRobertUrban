//
//  MenuController.swift
//  LePetitRobertUrban
//
//  Created by Nam-Robert Le on 01/10/2022.
//

import UIKit

class MenuController: UIViewController, UISearchBarDelegate {
    var wordToFound = "404"
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchWord = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchBar.delegate = self

    }
    
    

    @IBAction func randomButtonAction(_ sender: Any) {
        
        Task {
            await UrbanAPI.getRandomWord().done(on: .main, { word in
                self.wordToFound = word
            })
        }

        self.performSegue(withIdentifier: "toNavigationController", sender: nil)

    }
    
    @IBAction func searhButtonAction(_ sender: Any) {
        wordToFound = "404"
        self.performSegue(withIdentifier: "toNavigationController", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNavigationController" {
                
            if let navController = segue.destination as? UINavigationController {
                if let controller = navController.viewControllers[0] as? WordFinderController {
                    controller.wordToFound = wordToFound
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
