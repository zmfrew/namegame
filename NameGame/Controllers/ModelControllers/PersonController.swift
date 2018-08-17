//
//  PersonController.swift
//  NameGame
//
//  Created by Zachary Frew on 8/16/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import UIKit

class PersonController {
    
    // MARK: - URL Properties
    static let baseURL = URL(string: "https://willowtreeapps.com/api/v1.0/profiles/")
    
    // MARK: - Instance Methods
    static func retrieveAllPeople(completion: @escaping ([Person]?) -> Void) {
        guard let url = baseURL else { completion(nil); return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error occurred retrieving data from API: \(error.localizedDescription).")
                completion(nil)
                return
            }
            
            guard let data = data else { completion(nil); return }
            
            do {
                
                guard let resultsArray = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [AnyObject] else {
                    print("Json data was not converted correctly.")
                    completion(nil)
                    return
                }
                
                var people: [Person] = []
                
                for personDictionary in resultsArray {
                    if let person = Person(personDictionary: personDictionary as! [String: Any]) {
                        people.append(person)
                    }
                }
                
                completion(people)
                
            } catch {
                print("Error occurred decoding JSON data: \(error.localizedDescription).")
                completion(nil)
                return
            }
            
        }.resume()
        
    }
    
    // FIXME: - Refactor this method to avoid hard-coding URL.
    static func retrieveHeadshotFrom(person: Person, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: "https:" + person.headshotURL) else { completion(nil); return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error occurred retrieving heashot image: \(error.localizedDescription).")
                completion(nil)
                return
            }
            
            guard let data = data else { completion(nil); return }
            
            let headshot = UIImage(data: data)
            completion(headshot)
            
        }.resume()
        
    }
    
}
