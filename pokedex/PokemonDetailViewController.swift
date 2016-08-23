//
//  PokemonDetailViewController.swift
//  pokedex
//
//  Created by Marco Rojo on 20/08/16.
//  Copyright © 2016 Marco Rojo. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemon: Pokemon!
  
  @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
      
      nameLabel.text = pokemon.name

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
