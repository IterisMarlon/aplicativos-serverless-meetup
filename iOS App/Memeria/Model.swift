//
//  Model.swift
//  Memeria
//
//  Created by Marlon Morato on 31/07/19.
//  Copyright © 2019 Marlon Morato. All rights reserved.
//

import Foundation
import Moya

let BASE_URL: String = "https://functions-demo-12.azurewebsites.net/api"

struct Meme: Codable {
    let memeUrl: String
}

enum MemeApi {
    case getMeme
}

extension MemeApi: TargetType {
    var baseURL: URL {
        return URL(string: BASE_URL)!
    }
    
    var path: String {
        return "/HttpTriggerRandomMeme"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters: ["code" : "EydeX3rKNjUsBnG/4T5ygab0DGawECtkHfW/dYROqp3u0a1vWoXtcQ=="], encoding: URLEncoding.default)

    }
    
    var headers: [String : String]? {
        return nil
    }
}
