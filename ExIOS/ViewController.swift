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


// Extension for selfie
extension ViewController: SelfieDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    func takeSelfieTapped() {
        print("iamgen a tomar")
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("No image found")
            return
        }
    
    }
    
}
