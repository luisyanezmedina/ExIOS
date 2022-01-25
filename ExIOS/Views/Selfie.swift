//
//  Selfie.swift
//  ExIOS
//
//  Created by Jose Luis Yaenz on 22/01/22.
//

import Foundation
import UIKit

protocol SelfieDelegate {
    func takeSelfieTapped()

}

class Selfie: UIView {
    @IBOutlet weak var selfiePicture: UIImageView!
    
    var delegate: SelfieDelegate?
    
    init (selfiePictureView: UIImage) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    @IBAction func takeSelfie(_ sender: Any) {
        self.delegate?.takeSelfieTapped()
        print("tomar selfie")
        
    }
    

    func insertSelfie(selfieImage: UIImage){
        print("imagen", selfieImage)
        self.selfiePicture.image = selfieImage
    }
    
}
