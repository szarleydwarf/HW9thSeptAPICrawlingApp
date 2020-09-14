//
//  ViewController.swift
//  HW9thSeptAPICrawlingApp
//
//  Created by The App Experts on 09/09/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var urlString:String?="https://pokeapi.co/api/v2"
    var dictionary:[String:Any] = [:]
    var array:[Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        if let urlString = self.urlString, urlString.contains("https://"), let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, respons, error) in
                guard let data = data else {return}
                guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) else {return}
                if let dictionary = jsonObject as? [String:Any]{
                    self.dictionary = dictionary
                } else if let array = jsonObject as? [Any] {
                    self.array = array
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }.resume()
        }
    }
    
    func getKeyValue(index:Int)->(key:String, value:Any?) {
        let keys = Array(self.dictionary.keys)
        let key:String
        let value:Any
        if self.array.count > 0 {
            key = "\(index)"
            value = self.array[index]
        } else {
            key = keys[index]
            value = self.dictionary[key] as Any
        }
        return (key:key, value:value)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        if self.array.count > 0 {
            return self.array.count
        }
        return self.dictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.textColor = .gray
        cell.detailTextLabel?.textColor = .blue
        var isClickable = true
        if self.array.count > 0 {
            cell.textLabel?.text = "Element #\(indexPath.row)"
        } else {
            let tuple = getKeyValue(index: indexPath.row)
            cell.textLabel?.text = tuple.key
            if let value = tuple.value {
                if let dictValue = value as? [String: Any]{
                    cell.detailTextLabel?.text = "Dictionary with #\(dictValue.count) elements"
                } else if let arrayValue = value as? [[String : Any]]{
                    cell.detailTextLabel?.text = "Array with #\(arrayValue.count) elements"
                } else if let value = value as? String {
                    cell.detailTextLabel?.text = "\(value)"
                    if !value.contains("https"){
                        isClickable = false
                    }
                } else if let value = value as? Int {
                    cell.detailTextLabel?.text = "\(value)"
                    isClickable = false
                } else {
                    cell.detailTextLabel?.text = "nil"
                    isClickable = false
                }
            }
        }
        
        cell.isUserInteractionEnabled = isClickable
        return cell
    }
}

extension ViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "ViewController") as! ViewController
        let value = self.getKeyValue(index: indexPath.row).value
        if let value = value as? String {
            viewController.urlString = "\(value)"
        } else if let dictValue = value as? [String:Any] {
            viewController.dictionary = dictValue
            viewController.urlString = nil
        } else if let arrValue = value as? [Any] {
            viewController.array = arrValue
            viewController.urlString = nil
        }
        self.tableView.reloadData()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
