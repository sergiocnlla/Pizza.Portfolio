//
//  Auth.swift
//  pizza
//
//  Created by Sergio Canella on 09/06/21.
//

import Foundation

class Auth {
    struct Authentication:Decodable
    {
        var accessToken:String = ""
        var tokenType:String = ""
    }
    
    func SignIn(email: String, password: String, _ completion: @escaping (Authentication) -> ())
    {
        execSignIn(email:email, password:password) {
            (auth) in
            DispatchQueue.main.async {
                completion(auth)
            }
        }
    }
    
    func execSignIn(email: String, password: String, _ authentication: @escaping (Authentication) -> ())
    {
        let endpointurl = "\(AppSettings.endPointURL)\(AppSettings.signinPath)"
        
        var request = URLRequest(url: URL(string: endpointurl)!)
        request.httpMethod = "POST"
        
        let parameters: [String: Any] =
        [
            "email":email,
            "password":password
        ]
        
        do
        {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        }
        catch let error
        {
            authentication(Authentication())
            print("Error", error)
            return
        }
        
        guard let url = URL(string: endpointurl) else {return}
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else
            {
                print(error?.localizedDescription ?? "Response Error")
                authentication(Authentication())
                return
            }
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                
                guard let row = jsonResponse as? [String: Any] else {
                    authentication(Authentication())
                    return
                }
                
                print(row)
                
                authentication(Authentication(accessToken: row["accessToken"] as? String ?? "", tokenType: row["tokenType"] as? String ?? ""))
            }
            catch let parsingError
            {
                authentication(Authentication())
                print("Error", parsingError)
                return
            }
        }
        task.resume()
    }
}
