//
//  ChartEncuestaResponse.swift
//  ExIOS
//
//  Created by Jose Luis Yaenz on 23/01/22.
//

import Foundation

struct ChartEncuestaResponse: Codable {
    var colors: [String] = [String]()
    var questions: [Question] = [Question]()
}

struct Question: Codable {
    var total: Int
    var text: String
    var chartData: [chartDatas] = [chartDatas]()
}

struct chartDatas: Codable {
    var text: String
    var percetnage: Int
}
