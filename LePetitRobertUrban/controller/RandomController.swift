//
//  RandomController.swift
//  LePetitRobertUrban
//
//  Created by Nam-Robert Le on 01/10/2022.
//

import Foundation
import UIKit

class RandomController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var definitionLabel: UILabel!
    
    @IBOutlet weak var exempleLabel: UILabel!
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let urbanAPI = UrbanAPI()
        let word  = urbanAPI.getWord(searchWord: "wat")
        
        
        /*
        titleLabel.text = word.word
        definitionLabel.text = word.definitions[0].definition
        exempleLabel.text = word.definitions[0].exemple
        
        print("rngcontroller")
        print(word.word)
         */
    }
    
    


}
