//
//  Character.swift
//  RickAndMorty
//
//  Created by Jesús Fernández on 15/12/22.
//

import Foundation

class CharactersResponse : Decodable {
    var info : CharacterInfo?
    var results : [RickCharacter]?
}

class CharacterInfo : Decodable {
    var count : Int?
    var pager : Int?
    var next : String?
    var prev : String?
    
}

class RickCharacter : Decodable {
    var name : String?
    var status : String?
    var species : String?
    var gender : String?
    var image : String?
    var episode : String?
    
}
