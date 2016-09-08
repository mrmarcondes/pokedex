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
  private var _name: String!
  private var _pokedexId: Int!
  private var _description: String!
  private var _type: String!
  private var _defense: String!
  private var _weight: String!
  private var _height: String!
  private var _attack: String!
  private var _currentEvolutionURL: String!
  private var _nextEvolutionURL: String!
  private var _nextEvolutionPokedexId: String!
  private var _nextEvolutionName: String!
  private var _nextEvolutionLevel: String!
  private var _pokemonURL: String!
  
  
  var name: String {
    return _name
  }
  
  var pokedexId: Int {
    return _pokedexId
  }
  
  var description: String {
    if _description == nil {
      _description = ""
    }
    return _description
  }
  
  var type: String {
    if _type == nil {
      _type = ""
    }
    return _type
  }
  
  var defense: String {
    if _defense == nil {
      _defense = ""
    }
    return _defense
  }
  
  var weight: String {
    if _weight == nil {
      _weight = ""
    }
    return _weight
  }
  
  var height: String {
    if _height == nil {
      _height = ""
    }
    return _height
  }
  
  var attack: String {
    if _attack == nil {
      _attack = ""
    }
    return _attack
  }
  
  var nextEvolutionPokedexId: String {
    if _nextEvolutionPokedexId == nil {
      _nextEvolutionPokedexId = ""
    }
    return _nextEvolutionPokedexId
  }
  
  var nextEvolutionName: String {
    if _nextEvolutionName == nil {
      _nextEvolutionName = ""
    }
    return _nextEvolutionName
  }
  
  var nextEvolutionLevel: String {
    if _nextEvolutionLevel == nil {
      _nextEvolutionLevel = ""
    }
    return _nextEvolutionLevel
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
        
        if let descriptionsArray = dictionary["descriptions"] as? [Dictionary<String, String>], descriptionsArray.count > 0 {
          if let url = descriptionsArray[0]["resource_uri"] {
            let resourceURL = "\(URL_BASE)\(url)"
            Alamofire.request(resourceURL, withMethod: .get).responseJSON { (response) in
              let result = response.result
              
              if let dictionary = result.value as? Dictionary<String, AnyObject> {
                if let description = dictionary["description"] as? String {
                  self._description = description
                }
              }
              completed()
            }
          }
        } else {
          self._description = ""
        }

        if let evolutions = dictionary["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0 {
          if let to = evolutions[0]["to"] as? String {
            if to.range(of: "mega") == nil {
              if let evolutionURI = evolutions[0]["resource_uri"] {
                let nextEvolutionPokedexId = evolutionURI.replacingOccurrences(of: URL_POKEMON, with: "").replacingOccurrences(of: "/", with: "")
                self._nextEvolutionPokedexId = nextEvolutionPokedexId
                self._nextEvolutionName = to
                
                if let level = evolutions[0]["level"] as? Int {
                  self._nextEvolutionLevel = "\(level)"
                }
              }
            }
          }
        }
        else {
          
        }
        
        
      }
      
    }
  }
}
