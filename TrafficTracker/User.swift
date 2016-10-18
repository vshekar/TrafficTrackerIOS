//
//  User.swift
//  TrafficTracker
//
//  Created by Christian Ellis on 10/15/16.
//  Copyright © 2016 Christian Ellis. All rights reserved.
//

import Foundation

public enum Race {
    case none
    case White
    case Other
}
public enum Gender {
    case none
    case Male
    case Female
    case Transgender
    case Other
}
public enum Occupation{
    case none
    case Engineer
    case other
}


class User{
    var age: Int = 0
    var race: Race
    var gender: Gender
    var occupation: Occupation
    
    init (age: Int){
        self.age = age
        self.race = Race.none
        self.gender = Gender.none
        self.occupation = Occupation.none
    }
}
