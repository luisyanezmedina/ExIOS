//
//  ChartController.swift
//  ExIOS
//
//  Created by Jose Luis Yaenz on 23/01/22.
//

import UIKit

class ChartController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.getDataChart()
    }
    

    func getDataChart(){
        let apiService = ApiService(baseUrl: "https://us-central1-bibliotecadecontenido.cloudfunctions.net/helloWorld")
        apiService.apiRequestMet(methodType: .get) { responseJson, error in
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: responseJson as Any)
                let data = Data(jsonData)
                let decoder = JSONDecoder()
                let model = try decoder.decode(ChartEncuestaResponse.self, from: data)
                
            } catch {
                print("hubo un error", error)
            }
            
            
        }
    }

}
