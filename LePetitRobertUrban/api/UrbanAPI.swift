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
            
            var word: Word?
            // On fait l'appel dans la promesse
            let headers = [
                "X-RapidAPI-Key": "d76b23bb01mshc93ea5954cb8cbep1e91f0jsn9cf4154fc556",
                "X-RapidAPI-Host": "mashape-community-urban-dictionary.p.rapidapi.com"
            ]
            
            AF.request("https://mashape-community-urban-dictionary.p.rapidapi.com/define?term=\(searchWord)").response { response in
               let json = JSON(response.data)
                
                print(json)
                
                if let wordSafe = word {
                    seal.fulfill(wordSafe)
                } else {
                    seal.reject(NSError(domain: "app", code: 999, userInfo: ["erreur": "mot inconnu"]))
                }
                
            }
        }
        
        
        /*
        
        let headers = [
            "X-RapidAPI-Key": "d76b23bb01mshc93ea5954cb8cbep1e91f0jsn9cf4154fc556",
            "X-RapidAPI-Host": "mashape-community-urban-dictionary.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://mashape-community-urban-dictionary.p.rapidapi.com/define?term=wat")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("EROOOOOOR")
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print("NOOOOT EROOOOOR")
                print(JSON(data)["list"][0]["definition"])
                print(JSON(data)["list"][0]["example"])
            }
        })

        dataTask.resume()*/
        
        

    }
    
    func getRandomWord() -> Word{
        var definition = Definition(word: "hello", definition: "", exemple: "")
        
        let headers = [
            "X-RapidAPI-Key": "d76b23bb01mshc93ea5954cb8cbep1e91f0jsn9cf4154fc556",
            "X-RapidAPI-Host": "mashape-community-urban-dictionary.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.urbandictionary.com/v0/random")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("EROOOOOOR")
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(JSON(data)["list"][0]["word"])
                print(JSON(data)["list"][0]["definition"])
                print(JSON(data)["list"][0]["example"])
            
                print(definition.word)
                
                definition = Definition(word: JSON(data)["list"][0]["word"].stringValue, definition: JSON(data)["list"][0]["definition"].stringValue, exemple: JSON(data)["list"][0]["example"].stringValue)
                print("allo")
                print(definition.word)
            }
        })

        dataTask.resume()
        
        

        var word = Word(word: definition.word)
        word.definitions.append(definition)
        
        return word
    }
}
