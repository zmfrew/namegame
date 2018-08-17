//
//  MainGameViewController.swift
//  NameGame
//
//  Created by Zachary Frew on 8/16/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import UIKit

class MainGameViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var topLeftButton: UIButton!
    @IBOutlet weak var topRightButton: UIButton!
    @IBOutlet weak var middleLeftButton: UIButton!
    @IBOutlet weak var middleRightButton: UIButton!
    @IBOutlet weak var bottomLeftButton: UIButton!
    @IBOutlet weak var bottomRightButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var displayLabel: UILabel!
    
    // MARK: - Instance Properties
    var people: [Person]?
    
    var peopleImages: [UIImage] = [] {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PersonController.retrieveAllPeople { (people) in
            guard let people = people else { return }
            self.people = people
            DispatchQueue.main.async {
                self.displayLabel.text = people.first?.fullName ?? "Ain't nobody here"
            }
            for person in people {
                PersonController.retrieveHeadshotFrom(person: person, completion: { (image) in
                    guard let image = image else { return }
                    self.peopleImages.append(image)
                })
            }
        }
    }
    
    // MARK: - Instance Methods
    func updateViews() {
        if peopleImages.count <= 5 {
            return
        }
        DispatchQueue.main.async {
            self.topLeftButton.setBackgroundImage(self.peopleImages[0], for: .normal)
            self.topRightButton.setBackgroundImage(self.peopleImages[1], for: .normal)
            self.middleLeftButton.setBackgroundImage(self.peopleImages[2], for: .normal)
            self.middleRightButton.setBackgroundImage(self.peopleImages[3], for: .normal)
            self.bottomLeftButton.setBackgroundImage(self.peopleImages[4], for: .normal)
            self.bottomRightButton.setBackgroundImage(self.peopleImages[5], for: .normal)
        }
    }
    
    
}
