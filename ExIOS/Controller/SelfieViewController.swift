//
//  SelfieViewController.swift
//  ExIOS
//
//  Created by Jose Luis Yaenz on 24/01/22.
//

import UIKit

class SelfieViewController: UIViewController {

    @IBOutlet weak var SelfieImage: UIImageView!
    var newImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        SelfieImage.image = newImage
    }
    

}
