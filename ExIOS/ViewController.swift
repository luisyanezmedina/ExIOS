//
//  ViewController.swift
//  ExIOS
//
//  Created by Jose Luis Yaenz on 21/01/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var menuTable: UITableView!
    
    var selfieImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        menuTable.delegate = self
        menuTable.dataSource = self
        self.selfieImage = UIImage(named: "geek")
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
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 1 {
        
            let alert = UIAlertController(title: "Aviso", message: "Deseas tomar la selfie?", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "Visualizar", style: UIAlertAction.Style.default, handler: { action in
                self.performSegue(withIdentifier: "showSelfie", sender: self)
            }))
            
            alert.addAction(UIAlertAction(title: "Retomar/Tomar", style: UIAlertAction.Style.default, handler: { action in
                self.takeSelfieTapped()
            }))
            alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.destructive, handler: nil))

            self.present(alert, animated: true, completion: nil)
        }
        if indexPath.row == 2 {
            performSegue(withIdentifier: "showCharts", sender: self)
        }
    }
    
    
}



// Extension for selfie
extension ViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
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
        
        self.selfieImage = image
        performSegue(withIdentifier: "showSelfie", sender: self.selfieImage)
    }
    
    /**
     Set image for the next view controller
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if (segue.identifier == "showSelfie") {
           let svc = segue.destination as! SelfieViewController
           if sender is UIImage {
               let image = sender as! UIImage
               svc.newImage = image
           }else {
               svc.newImage = self.selfieImage
           }
       }
    }
    
}
