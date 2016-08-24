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
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var pokedexIdLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var nextEvolution: UIImageView!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      nameLabel.text = pokemon.name

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
  
    @IBAction func backButtonTapped(_ sender: AnyObject) {
      dismiss(animated: true, completion: nil)
    }
}
