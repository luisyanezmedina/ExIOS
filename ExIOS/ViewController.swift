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
    
    @IBAction func takeSelfieAction(_ sender: Any) {
        self.configSelfieAlert()
    }
    
    func configSelfieAlert() {
        
        let selfieNib = UINib(nibName: "Selfie", bundle: nil)
        let viewSelfie = selfieNib.instantiate(withOwner: self, options: nil)[0] as! UIView
    
        viewSelfie.frame = view.bounds
        view.addSubview(viewSelfie)

    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if indexPath.row == 0 {
            let celda = menuTable.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! NombreCell
            celda.NombreTextField.delegate = self
            return celda
            
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

extension ViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z].*", options: [])
            if regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil {
                return false
            }
        }
        catch {
            print("ERROR")
        }
        return true
    }
}
