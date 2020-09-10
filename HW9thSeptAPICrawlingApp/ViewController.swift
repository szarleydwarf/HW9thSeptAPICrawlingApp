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
    var presenter:[Presenters] = [StringPresenter()]
    let apiGrabber = ApiGrabber()
    var baseDictionary:[String:Any]=[:]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.baseDictionary = self.apiGrabber.baseDictionary
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.baseDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "mainCell")
        let keys = Array(self.baseDictionary.keys)
        let key = keys[indexPath.row]
        let value = self.baseDictionary[key]
        
        cell.textLabel?.text = key
        cell.detailTextLabel?.text = "\(value)"
        
        return cell
    }
    
    
}

extension ViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewControler = storyboard.instantiateViewController(identifier: "ViewController")
        
        self.navigationController?.pushViewController(viewControler, animated: true)
    }
}
