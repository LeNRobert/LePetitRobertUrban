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

    
    var randomWord = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
/*
        UrbanAPI.getRandomWord().done(on: .main, { word in
            self.randomWord = word
            
            UrbanAPI.getWord(searchWord: self.randomWord).done(on: .main, { word in
                print("length : \(word.definitions.count)")
                var length = word.definitions.count-2
                if length < 0{
                    length = 1
                }
                for i in 0...length{
                    print("\(i) : \(word.word)")
                    print(word.definitions[i].definition)
                }
            })
            
            
        })

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
