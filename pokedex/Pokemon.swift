//
//  Pokemon.swift
//  pokedex
//
//  Created by Marco Rojo on 31/07/16.
//  Copyright © 2016 Marco Rojo. All rights reserved.
//

import Foundation

class Pokemon {
  private var _name: String!
  private var _pokedexId: Int!
  
  var name: String {
    return _name
  }
  
  var pokedexId: Int {
    return _pokedexId
  }
  
  init(name: String, pokedexId: Int) {
    self._name = name
    self._pokedexId = pokedexId
  }
}
