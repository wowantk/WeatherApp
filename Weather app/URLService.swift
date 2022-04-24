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
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let result: Wheather?
            
            let wrappedCompletion: (Bool, Wheather?) -> Void = { (flag, wheather) in
                DispatchQueue.main.async {
                    completion(flag, wheather)
                }
            }
            
            guard data != nil else {
                wrappedCompletion(false, nil)
                return
            }
            
            guard error == nil else {
                wrappedCompletion(false, nil)
                return
            }
            
            do {
                result =  try JSONDecoder().decode(Wheather.self, from: data!)
                wrappedCompletion(true, result)
            } catch {
                wrappedCompletion(false, nil)
            }
        }
        task.resume()
    }
    
}
