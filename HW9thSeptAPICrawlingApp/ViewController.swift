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
    var baseDictionary:[BaseDictionaryElement]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        print("Data-> \(self.apiGrabber.data)")
        self.baseDictionary = self.apiGrabber.baseDictionary
        print(self.baseDictionary?.count ?? 0)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.baseDictionary?.count ?? 0)
        return self.baseDictionary?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "mainCell")
        let dictionary = self.baseDictionary?[indexPath.row]
        cell.textLabel?.text = dictionary?.name
        cell.detailTextLabel?.text = dictionary?.url
        
        return cell
    }
    
    
}

extension ViewController:UITableViewDelegate {
    
}
