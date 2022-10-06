//
//  wikiHowAPI.swift
//  TutoComment
//
//  Created by Nam-Robert Le on 30/09/2022.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

class UrbanAPI{
    
    //Fonction static pour ne pas a avoir a l'instancier a chaque fois qu'on veux la call
    /*
    static func getTuto() -> Promise<[Tuto]> {
        var tutos: [Tuto] = []
        
        // Gestion de l'asynchrone, on retourne une promesse
        
    }*/
    
    
    func getWord(searchWord: String) -> Promise<Word>{
        
        return Promise { seal in
            
            // On fait l'appel dans la promesse
            let headers: HTTPHeaders = [
                "X-RapidAPI-Key": "d76b23bb01mshc93ea5954cb8cbep1e91f0jsn9cf4154fc556",
                "X-RapidAPI-Host": "mashape-community-urban-dictionary.p.rapidapi.com"
            ]
            
            AF.request("https://mashape-community-urban-dictionary.p.rapidapi.com/define?term=\(searchWord)", headers: headers).response { response in
               let json = JSON(response.data)
                
                print(json)
                let word = Word(word: searchWord)
                
                
                let  jsonLength = json["list"].count
                for i in 0...jsonLength{
                    print(json["list"][i]["definition"].stringValue)
                    var definition: Definition = Definition(word: json["list"][i]["word"].stringValue, definition: json["list"][i]["definition"].stringValue, exemple: json["list"][i]["example"].stringValue)
                    word.definitions.append(definition)
                }
                
                
                seal.fulfill(word)
                
            }
        }
        
        
    }
    
    func getRandomWord() -> String {
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.urbandictionary.com/v0/random")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)


        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                let randomWord = JSON(data)["list"][0]["word"].stringValue
            }
        })
        dataTask.resume()
        return ""
    }
}
