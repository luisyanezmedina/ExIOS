//
//  ApiService.swift
//  ExIOS
//
//  Created by Jose Luis Yaenz on 23/01/22.
//

import Foundation
import Alamofire

class ApiService {
    
    private var baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func apiRequestMet(methodType: Alamofire.HTTPMethod,
                    params: Parameters? = [String:Any](),
                    completion:@escaping (_ value: Any?, _ error: NSError?) -> Void) {
        
        switch methodType {
            case .get:
                //
            AF.request(baseUrl, method: .get, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON { (responseData) in
                if (responseData.error as? NSError) != nil {
                    completion(nil, responseData.error as NSError?)
                }else {
                    completion (responseData.value, nil)
                }
                
            }
                
                break
            case .post, .put:
                break
            default:
                break
        }
        
    }
    
} // Class
