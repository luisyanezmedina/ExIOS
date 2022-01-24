//
//  ChartController.swift
//  ExIOS
//
//  Created by Jose Luis Yaenz on 23/01/22.
//

import UIKit
import Charts
import FirebaseDatabase


class ChartController: UIViewController, ChartViewDelegate, UIScrollViewDelegate {
  
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.delegate = self
        
        return scroll
    }()
    
    private let db = Database.database().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        
        self.getDataChart()
    }
    

    /**
    Get data from Web Service
     */
    func getDataChart(){
        
        // Change UIView background color from Firebase
        db.child("configuration").observeSingleEvent(of: .value){(snapshot) in
            
            guard let bgColor = snapshot.value as? [String: String] else {return}
            var bgColorStr: String = "0x"
            bgColorStr += bgColor["bgColor"]!
          
            guard let bgColorNumber = UInt32( String(bgColorStr.suffix(6) ), radix: 16 ) else {print("error en color firebase"); return}
            
            self.view.backgroundColor = UIColor(rgb: UInt(bgColorNumber) )
            print("bgColor ", bgColorNumber)
        }
        
        let apiService = ApiService(baseUrl: "https://us-central1-bibliotecadecontenido.cloudfunctions.net/helloWorld")
        apiService.apiRequestMet(methodType: .get) { responseJson, error in
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: responseJson as Any)
                let data = Data(jsonData)
                let decoder = JSONDecoder()
                let model = try decoder.decode(ChartEncuestaResponse.self, from: data)
                
                for (index, question) in model.questions.enumerated() {
                    self.configChart(valuesResponse: question.chartData, chartTitle: question.text, iteration: index)
                }
                
            } catch {
                print("hubo un error", error)
            }
            
        }
    }
    
    /**
     Config current chart with values, colors and labels
     */
    func configChart(valuesResponse: [chartDatas], chartTitle: String, iteration: Int){
        var entries: [PieChartDataEntry] = Array()
        let pieChartInstance = PieChartView()
        
        let c1 = UIColor(rgb: 0xA11DF0)
        let c2 = UIColor(rgb: 0x1D7BF0)
        let c3 = UIColor(rgb: 0x6C1EFA)
        let c4 = UIColor(rgb: 0x3627E3)
        let c5 = UIColor(rgb: 0x1E46FA)
        
        for item in valuesResponse {
            entries.append(PieChartDataEntry(value: Double(item.percetnage), label: item.text))
        }
        
        let dataSet = PieChartDataSet(entries: entries, label: chartTitle)
        pieChartInstance.data = PieChartData(dataSet: dataSet)
        
        let height = self.view.frame.size.height * CGFloat(iteration)
        dataSet.colors = [c1,c2,c3,c4,c5]
        pieChartInstance.frame = CGRect(x: 0, y: height , width: self.view.frame.size.width, height: self.view.frame.size.height)
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: height)
        
        scrollView.addSubview(pieChartInstance)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let layout = view.safeAreaLayoutGuide
        scrollView.centerXAnchor.constraint(equalTo: layout.centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: layout.centerYAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: layout.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: layout.heightAnchor).isActive = true
    }

} // Class
