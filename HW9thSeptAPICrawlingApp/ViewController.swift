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
    var urlString:String="https://pokeapi.co/api/v2"
    var dictionary:[String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        if let url = URL(string: self.urlString) {    
            URLSession.shared.dataTask(with: url) { (data, respons, error) in
                guard let data = data else {return}
                guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {return}
                self.dictionary = jsonObject
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }.resume()
        }
    }
    
    func getKeyValue(index:Int)->(key:String, value:Any?) {
        let keys = Array(self.dictionary.keys)
        let key = keys[index]
        let value = self.dictionary[key]
        return (key:key, value:value)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        return self.dictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let tuple = getKeyValue(index: indexPath.row)
        cell.textLabel?.textColor = .gray
        cell.textLabel?.text = tuple.key
        cell.detailTextLabel?.textColor = .blue
        if let value = tuple.value {
            cell.detailTextLabel?.text = "\(value)"
        }
        return cell
    }
    
    
}

extension ViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "ViewController") as! ViewController
        if let value = self.getKeyValue(index: indexPath.row).value {
            viewController.urlString = "\(value)"
        }
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
