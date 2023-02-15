//
//  Character.swift
//  RICK_AND_MORTY
//
//  Created by Jesús Fernández on 16/12/22.
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
    var image : String?
    var species : String?
 
    
}
