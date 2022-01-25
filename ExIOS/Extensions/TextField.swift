//
//  TextField.swift
//  ExIOS
//
//  Created by Jose Luis Yaenz on 24/01/22.
//

import Foundation
import UIKit

/**
 Delegate for UIText accept only alphabetical letters
 */
extension ViewController: UITextFieldDelegate {
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
