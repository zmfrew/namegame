//
//  Person.swift
//  NameGame
//
//  Created by Zachary Frew on 8/16/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import Foundation

class Person {
    
    // MARK: - Key Constants
    private let firstNameKey = "firstName"
    private let lastNameKey = "lastName"
    private let jobTitleKey = "jobTitle"
    private let headshotKey = "headshot"
    private let headshotURLKey = "url"
    
    // MARK: - Properties
    let firstName: String
    let lastName: String
    let fullName: String
    let jobTitle: String?
    let headshotURL: String
    
    // MARK: - Initializers
    init(firstName: String, lastName: String, jobTitle: String?, headshotURL: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = "\(firstName) \(lastName)"
        self.jobTitle = jobTitle
        self.headshotURL = headshotURL
    }
    
    init?(personDictionary: [String: Any]) {
        guard let firstName = personDictionary[firstNameKey] as? String,
            let lastName = personDictionary[lastNameKey] as? String,
            let jobTitle = personDictionary[jobTitleKey] as? String,
            let headshotDictionary = personDictionary[headshotKey] as? [String: Any],
            let headshotURL = headshotDictionary[headshotURLKey] as? String
            else { return nil }
        
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = "\(firstName) \(lastName)"
        self.jobTitle = jobTitle
        self.headshotURL = headshotURL
    }
    
}
