//
//  NetworkManager.swift
//  FrogmiTest
//
//  Created by Jimmy Hernandez on 23-04-20.
//  Copyright © 2020 Jimmy Hernandez. All rights reserved.
//

import Foundation
import Promise
import Alamofire
import SwiftyJSON

class NetworkManager {
    
    //MARK: - Singleton
    class var shared: NetworkManager{
        struct Static {
            static let instance = NetworkManager()
        }
        return Static.instance
    }
    
    var arrStore = [Store]()
    var page = 1
    var xTotalPages = 3
    
    public func getListStore(per_page: Int)->Promise<[Store]> {
        return Promise<[Store]>(work: {
            fullfill,reject in
            
            if self.page == self.xTotalPages {
                reject(NSError(domain: "", code: 100, userInfo: [
                    NSLocalizedDescriptionKey: "Promise Error Sample"]))
                return
            }
            
            let parameters: Parameters = [
                "page": self.page,
                "per_page": per_page
            ]
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer cea717e4103b9918f4c32838e61dbe2d",
                "X-Company-UUID": "b7fa583e-a144-4ec2-9464-e1e514512fb4"
            ]
            
            AFWrapper.requestGETURL("https://api.frogmi.com/api/v2/mobile/stores", parameters: parameters, headers: headers, success: { (responseObject) in
                
                
                for aPo in responseObject["metadata"] as!  NSDictionary {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: aPo.value, options: .prettyPrinted)
                        let reqJSONStr = String(data: jsonData, encoding: .utf8)
                        let data = reqJSONStr?.data(using: .utf8)
                        let jsonDecoder = JSONDecoder()
                        let aResultSong = try jsonDecoder.decode(Pagination.self, from: data!)
                        self.page = Int(aResultSong.xNextPage) ?? 1
                        print("RESULT gfgf")
                        print(aResultSong)
                    }
                    catch {
                        reject(error)
                        return
                    }
                }
                
                for aResult in responseObject["stores"] as! [Any] {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: aResult, options: .prettyPrinted)
                        let reqJSONStr = String(data: jsonData, encoding: .utf8)
                        let data = reqJSONStr?.data(using: .utf8)
                        let jsonDecoder = JSONDecoder()
                        let aResultSong = try jsonDecoder.decode(Store.self, from: data!)
                        self.arrStore.append(aResultSong)
                    }
                    catch {
                        reject(error)
                        return
                    }
                }
                fullfill(self.arrStore)
                return
            }) { (error) in
                print(error.localizedDescription)
                reject(error)
                return
            }
            
        })
    }
    
}
