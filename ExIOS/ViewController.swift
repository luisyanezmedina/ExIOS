//
//  ViewController.swift
//  ExIOS
//
//  Created by Jose Luis Yaenz on 21/01/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var menuTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        menuTable.delegate = self
        menuTable.dataSource = self
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if indexPath.row == 0 {
            cell = menuTable.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        } else if indexPath.row == 1 {
            cell = menuTable.dequeueReusableCell(withIdentifier: "menuCellSelfie", for: indexPath)
        }
        else if indexPath.row == 2 {
            cell = menuTable.dequeueReusableCell(withIdentifier: "menuCellGraficas", for: indexPath)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        if indexPath.row == 2 {
            performSegue(withIdentifier: "showCharts", sender: self)
        }
    }
    
}
