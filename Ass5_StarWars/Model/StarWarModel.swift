//
//  File.swift
//  Ass5_StarWars
//
//  Created by user228139 on 11/11/22.
//

import Foundation

struct StarWarModel: Codable {
    let next : String?
    let results : [Results]?
}

struct Results: Codable {
    let name : String?
    let eye_color : String?
    let hair_color : String?
    let homeworld : String?
    let films : [String]?
}
