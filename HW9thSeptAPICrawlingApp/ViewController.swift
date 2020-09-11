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
    let apiGrabber = ApiGrabber()
    var dictionary:[String:Any]=[:]
    var array:[Any]=[]
    var urlString:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.dictionary = self.apiGrabber.dictionary
        
        self.tableView.reloadData()
    }
    
    func getKeyValue(index:Int)->(key:String, value:Any) {
        let keys = Array(self.dictionary.keys)
        let key = keys[index]
        let value = self.dictionary[key]
        return (key:key, value:value as Any)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        return self.dictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let tuple = self.getKeyValue(index: indexPath.row)
        cell.textLabel?.text = tuple.key
        if let value = tuple.value as? String {
            cell.detailTextLabel?.text = "\(value)"
        }
        return cell
    }
    
    
}

extension ViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewControler = storyboard.instantiateViewController(identifier: "ViewController") as ViewController
        let tuple = self.getKeyValue(index: indexPath.row)
        if let value = tuple.value as? String{
            viewControler.urlString = "\(value)"
            self.apiGrabber.urlString = "\(value)"
            print("value>\(value) > \(self.apiGrabber.urlString)")
        }
        self.navigationController?.pushViewController(viewControler, animated: true)
    }
}
