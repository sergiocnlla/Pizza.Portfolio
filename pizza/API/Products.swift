//
//  pizzas.swift
//  pizza
//
//  Created by Sergio Canella on 09/06/21.
//

import Foundation

class Products {
    struct Pizza:Decodable
    {
        var id:UUID = UUID()
        var name:String = ""
        var imageURL:String = ""
        var rating:Int = 0
        var priceP:Double = 0.00
        var priceM:Double = 0.00
        var priceG:Double = 0.00
        var image:Data = Data()
    }
    
    func GetPizzas(_ completion: @escaping ([Pizza]) -> ())
    {
        execGetPizzas {
            (pizzas) in
            DispatchQueue.main.async {
                completion(pizzas)
            }
        }
    }
    
    func execGetPizzas(_ pizzas: @escaping ([Pizza]) -> ())
    {
        let endpointurl = "\(AppSettings.endPointURL)\(AppSettings.getPizzaPath)"
        
        var request = URLRequest(url: URL(string: endpointurl)!)
        request.httpMethod = "GET"
        
        do
        {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        }
        catch
        {
            pizzas([])
            return
        }
        
        guard let url = URL(string: endpointurl) else {return}
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else
            {
                print(error?.localizedDescription ?? "Response Error")
                pizzas([])
                return
            }
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                
                guard let jsonArray = jsonResponse as? [[String: Any]] else {
                    pizzas([])
                    return
                }
                
                var pizzasArray:[Pizza] = []
                
                for row in jsonArray
                {
                    let pizzaRow = Pizza(id: UUID(uuidString: row["id"] as? String ?? "") ?? UUID(), name: row["name"] as? String ?? "", imageURL: row["imageUrl"] as? String ?? "", rating: row["rating"] as? Int ?? 0, priceP: row["priceP"] as? Double ?? 0.00, priceM: row["priceM"] as? Double ?? 0.00, priceG: row["priceG"] as? Double ?? 0.00)
                    
                    pizzasArray.append(pizzaRow)
                }
                
                pizzas(pizzasArray)
            }
            catch let parsingError
            {
                pizzas([])
                print("Error", parsingError)
                return
            }
        }
        task.resume()
    }
}
