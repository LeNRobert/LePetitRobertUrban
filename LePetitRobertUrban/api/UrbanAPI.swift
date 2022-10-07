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
    
    static func getWord(searchWord: String) -> Promise<Word>{
        
        return Promise { seal in
            
            // On fait l'appel dans la promesse
            let headers: HTTPHeaders = [
                "X-RapidAPI-Key": "d76b23bb01mshc93ea5954cb8cbep1e91f0jsn9cf4154fc556",
                "X-RapidAPI-Host": "mashape-community-urban-dictionary.p.rapidapi.com"
            ]
            
            AF.request("https://mashape-community-urban-dictionary.p.rapidapi.com/define?term=\(searchWord)", headers: headers).response { response in
               let json = JSON(response.data)
                
                let word = Word(word: searchWord)
                
                let  jsonLength = json["list"].count
                for i in 0...jsonLength{
                    var definition: Definition = Definition(word: json["list"][i]["word"].stringValue, definition: json["list"][i]["definition"].stringValue, exemple: json["list"][i]["example"].stringValue)
                    word.definitions.append(definition)
                }

                seal.fulfill(word)
                
            }
        }
        
        
    }
    
    static func getRandomWord()-> Promise<String>{
        var word = ""
        return Promise { seal in
            
            // On fait l'appel dans la promesse
            let headers: HTTPHeaders = [
                "X-RapidAPI-Key": "d76b23bb01mshc93ea5954cb8cbep1e91f0jsn9cf4154fc556",
                "X-RapidAPI-Host": "mashape-community-urban-dictionary.p.rapidapi.com"
            ]
            
            AF.request("https://api.urbandictionary.com/v0/random", headers: headers).response { response in
               let json = JSON(response.data)
                word = json["list"][0]["word"].stringValue
                seal.fulfill(word)
                
            }
        }
    }
}
