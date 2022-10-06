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
                
                let definition: Definition = Definition(word: json["list"][0]["word"].stringValue, definition: json["list"][0]["definition"].stringValue, exemple: json["list"][0]["example"].stringValue)
                
                word.definitions.append(definition)
                seal.fulfill(word)
                
            }
        }
        
        
    }
    
    func getRandomWord() -> Promise<Word>{
        return Promise { seal in
            
            // On fait l'appel dans la promesse
            let headers: HTTPHeaders = [
                "X-RapidAPI-Key": "d76b23bb01mshc93ea5954cb8cbep1e91f0jsn9cf4154fc556",
                "X-RapidAPI-Host": "mashape-community-urban-dictionary.p.rapidapi.com"
            ]
            
            AF.request("https://api.urbandictionary.com/v0/random", headers: headers).response { response in
               let json = JSON(response.data)
                
                print(json)
                let word = Word(word:  json["list"][0]["word"].stringValue)
                
                let definition: Definition = Definition(word: json["list"][0]["word"].stringValue, definition: json["list"][0]["definition"].stringValue, exemple: json["list"][0]["example"].stringValue)
                
                word.definitions.append(definition)
                seal.fulfill(word)
            }
        }
    }
}
