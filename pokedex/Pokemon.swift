//
//  Pokemon.swift
//  pokedex
//
//  Created by Marco Rojo on 31/07/16.
//  Copyright © 2016 Marco Rojo. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
  fileprivate var _name: String!
  fileprivate var _pokedexId: Int!
  fileprivate var _description: String!
  fileprivate var _type: String!
  fileprivate var _defense: String!
  fileprivate var _weight: String!
  fileprivate var _height: String!
  fileprivate var _attack: String!
  fileprivate var _currentEvolutionURL: String!
  fileprivate var _nextEvolutionURL: String!
  fileprivate var _pokemonURL: String!
  
  
  var name: String {
    return _name
  }
  
  var pokedexId: Int {
    return _pokedexId
  }
  
  init(name: String, pokedexId: Int) {
    self._name = name
    self._pokedexId = pokedexId
    
    self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId!)"
  }
  
  func downloadPokemonDetails(completed: DownloadComplete) {
    Alamofire.request(self._pokemonURL, withMethod: .get).responseJSON { (response) in
      let result = response.result
      
      if let dictionary = result.value as? Dictionary<String, AnyObject> {
        if let weight = dictionary["weight"] as? String {
          self._weight = weight
        }
        if let height = dictionary["height"] as? String {
          self._height = height
        }
        if let attack = dictionary["attack"] as? Int {
          self._attack = "\(attack)"
        }
        if let defense = dictionary["defense"] as? Int {
          self._defense = "\(defense)"
        }
        if let weight = dictionary["weight"] as? String {
          self._weight = weight
        }
        if let types = dictionary["types"] as? [Dictionary<String, String>] , types.count > 0 {
          var typeString = ""
          for type in types {
            if let name = type["name"] {
              typeString += "/ \(name.capitalized)"
            }
          }
          self._type = typeString.replacingCharacters(in: typeString.startIndex..<typeString.index(typeString.startIndex, offsetBy: 2), with: "")
        } else {
          self._type = ""
        }
        
        print(self._type)
        
        
      }
      
    }
  }
}
