//
//  URLService.swift
//

import Foundation
final class URLService {
    static func performRequset(URLBuilder: URLlBuilder,
                               completion: @escaping (_ isSuccess: Bool,  _ response: Wheather?) -> ()
    ) {
        guard let url = URLBuilder.getURL() else {
            return
        }
        print(url)
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let result: Wheather?
            
            let wrappedCompletion: (Bool, Wheather?) -> Void = { (flag, wheather) in
                DispatchQueue.main.async {
                    completion(flag, wheather)
                }
            }
            
            guard data != nil else {
                print("NO DATA")
                wrappedCompletion(false, nil)
                return
            }
            
            guard error == nil else {
                print(error!.localizedDescription)
                wrappedCompletion(false, nil)
                return
            }
            
            do {
                result =  try JSONDecoder().decode(Wheather.self, from: data!)
                wrappedCompletion(true, result)
            } catch {
                print(error.localizedDescription)
                wrappedCompletion(false, nil)
            }
        }
        task.resume()
        }

    }
