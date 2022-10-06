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
        
        let randomWord = urbanAPI.getRandomWord()
            /*.done { word in
            self.titleLabel.text = word.word
            self.definitionLabel.text = word.definitions[0].definition
            self.exempleLabel.text = word.definitions[0].exemple
            print("#######")
            print(word.word)
            print(word.definitions[0].definition)
            print(word.definitions[0].exemple)
        }
        */
        
       
        /*
         HearststoneApi.getCarts().done { cartes in
                     
                     self.nom.text = cartes[i].name
                     if let url = URL(string: cartes[i].image),let imgData = try? Data(contentsOf: url) {
                        let img = UIImage(data: imgData)
                        self.img.image = img
                     }
                 
                 }
         
         
        titleLabel.text = word.word
        definitionLabel.text = word.definitions[0].definition
        exempleLabel.text = word.definitions[0].exemple
        
        print("rngcontroller")
        print(word.word)
         */
    }
    
    


}
