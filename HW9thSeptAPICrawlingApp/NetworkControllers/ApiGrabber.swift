//
//  ApiGrabber.swift
//  HW9thSeptAPICrawlingApp
//
//  Created by The App Experts on 10/09/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import Foundation
import UIKit

class ApiGrabber {
    let urlString = "https://pokeapi.co/api/v2"
    var data:Data?
    var baseDictionary:[BaseDictionaryElement]?
    
    init() {
        guard let url = URL(string: urlString)else {return}
        
        URLSession.shared.dataTask(with: url) { (data, respons, error) in
            guard let data = data else {return}
            
            self.data = data
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {return}
            guard let baseDictionary = jsonObject as? [String: Any] else {return}
//            print("dictionary-> \(baseDictionary)")
            
            for (key, value) in baseDictionary {
               print("key> \(key) value>\(value)")
                self.baseDictionary?.append(BaseDictionaryElement(name: key, url: value as! String))
            }
            
        }.resume()
    }
    
    //todo might have string version as well
//    init(with url: URL){
//        URLSession.shared.dataTask(with: url) { (data, respons, error) in
//            guard let data = data else {return}
//            print("data->\(data)")
//            self.data = data
//        }.resume()
//    }
}

struct BaseDictionaryElement {
    var name:String
    var url:String
}
