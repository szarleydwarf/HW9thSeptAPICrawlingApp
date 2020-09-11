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
    var data:Data?
    var dictionary:[String:Any]=[:]
    var urlString: String?
    
    private func getData(_ url: URL) {
        URLSession.shared.dataTask(with: url) { (data, respons, error) in
            guard let data = data else {return}
            
            self.data = data
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) else {return}
            guard let baseDictionary = jsonObject as? [String: Any] else {return}
            self.dictionary = baseDictionary
        }.resume()
    }
    
    init(){
        print("1 url>\(self.urlString)")
        if self.urlString == nil {
            self.urlString = "https://pokeapi.co/api/v2"
        }
        print("2 url>\(self.urlString)")
        if let string = self.urlString{
            guard let url = URL(string: string)else {return}
            getData(url)
        }
    }
}
