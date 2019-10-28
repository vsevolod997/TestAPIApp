//
//  HttpService.swift
//  TestAPIApp
//
//  Created by Всеволод Андрющенко on 18.10.2019.
//  Copyright © 2019 Всеволод Андрющенко. All rights reserved.
//

import Foundation

class HttpService{
    
     class func sessionReqest(completion: @escaping(SessionResponse?, Error?)->Void){
           let data = "a=new_session"
           let url = URL(string: "https://bnet.i-partner.ru/testAPI/")!
           var request = URLRequest(url: url)
           request.httpBody = data.data(using: .utf8)
           request.httpMethod = "POST"
           request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
           request.setValue("uTlF3do-bu-DCTGPlI", forHTTPHeaderField: "token")
           let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
               if let error = error {
                   completion(nil, error)
               } else {
                   if let data = data{
                       do{
                           let date = try JSONDecoder().decode(SessionResponse.self, from: data)
                           completion(date, nil)
                       } catch let jsonError{
                           completion(nil, jsonError)
                       }
                   }
               }
           }
           task.resume()
       }
    
    class func entriesResponse(session: String,completion: @escaping(EntriesResponse?, Error?)->Void){
        let param = "a=get_entries&session=\(session)"
        let url = URL(string: "https://bnet.i-partner.ru/testAPI/")!
        var request = URLRequest(url: url)
        request.httpBody = param.data(using: .utf8)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("uTlF3do-bu-DCTGPlI", forHTTPHeaderField: "token")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, error)
            } else {
                if let data = data{
                    do{
                        let dataDecode = try JSONDecoder().decode(EntriesResponse.self, from: data)
                        completion(dataDecode, nil)
                    } catch let jsonError{
                        completion(nil, jsonError)
                    }
                }
            }
        }
        task.resume()
    }
    
    class func addEntryResponse(text: String, completion: @escaping(AddResponse?, Error?)->Void){
        let param  = "a=add_entry&session=\(SessionSingeltone.session.tokenStrings)&body=\(text)"
        let url = URL(string: "https://bnet.i-partner.ru/testAPI/")!
        var request = URLRequest(url: url)
        request.httpBody = param.data(using: .utf8)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("uTlF3do-bu-DCTGPlI", forHTTPHeaderField: "token")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, error)
            } else {
                if let data = data{
                   do{
                        let data = try JSONDecoder().decode(AddResponse.self, from: data)
                        completion(data, nil)
                    } catch let jsonError{
                        completion(nil, jsonError)
                    }
                }
            }
        }
        task.resume()
    }
    
}
