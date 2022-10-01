//
//  ViewController.swift
//  LePetitRobertUrban
//
//  Created by Nam-Robert Le on 30/09/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
   @IBAction func startButtonAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toMenuControllerSegue", sender: nil)
        
    }
    
    

}

