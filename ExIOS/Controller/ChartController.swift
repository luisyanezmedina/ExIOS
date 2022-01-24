//
//  ChartController.swift
//  ExIOS
//
//  Created by Jose Luis Yaenz on 23/01/22.
//

import UIKit
import Charts

class ChartController: UIViewController, ChartViewDelegate, UIScrollViewDelegate {
  
    lazy var scrollView: UIScrollView = {
            let scroll = UIScrollView()
            scroll.translatesAutoresizingMaskIntoConstraints = false
            scroll.delegate = self
            // scroll.contentSize = CGSize(width: self.view.frame.size.width, height: 1000)
            return scroll
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.pieChartOnePart.delegate = self
        view.addSubview(scrollView)
        
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
                
                for (index, question) in model.questions.enumerated() {
                    self.configChartOnePart(valuesResponse: question.chartData, chartTitle: question.text, iteration: index)
                }
                
            } catch {
                print("hubo un error", error)
            }
            
        }
    }
    
    func configChartOnePart(valuesResponse: [chartDatas], chartTitle: String, iteration: Int){
        var entries: [PieChartDataEntry] = Array()
        let pieChartInstance = PieChartView()
        
        for item in valuesResponse {
            entries.append(PieChartDataEntry(value: Double(item.percetnage), label: item.text))
        }
        
        let dataSet = PieChartDataSet(entries: entries, label: chartTitle)
        pieChartInstance.data = PieChartData(dataSet: dataSet)
        
        let c1 = UIColor(rgb: 0xE8bd54)
        let c2 = UIColor(rgb: 0x4d3ca6)
        let height = self.view.frame.size.height * CGFloat(iteration)
        dataSet.colors = [c1,c2]
        pieChartInstance.frame = CGRect(x: 0, y: height , width: self.view.frame.size.width, height: self.view.frame.size.height)
        //pieChartInstance.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height * CGFloat(iteration))
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
