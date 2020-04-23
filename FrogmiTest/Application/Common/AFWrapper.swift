//
//  AFWrapper.swift
//  FrogmiTest
//
//  Created by Jimmy Hernandez on 23-04-20.
//  Copyright © 2020 Jimmy Hernandez. All rights reserved.
//

import Foundation
import Alamofire

class AFWrapper: NSObject {
    class func requestGETURL(_ strURL: String, parameters: Parameters, headers: HTTPHeaders, success:@escaping ([String : Any]) -> Void, failure:@escaping (Error) -> Void) {
        AF.request(strURL, method: .get, parameters: parameters, encoding: URLEncoding(destination: .queryString), headers: headers).responseJSON { (responseObject) -> Void in
//            print(responseObject)
            switch responseObject.result {
            case .success( _):
                success(responseObject.value! as! [String : Any])
            case .failure( _):
                let _ = responseObject.error!
            }
        }
    }
}
