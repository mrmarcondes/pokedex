//
//  PokemonDetailViewController.swift
//  pokedex
//
//  Created by Marco Rojo on 20/08/16.
//  Copyright © 2016 Marco Rojo. All rights reserved.
//

import UIKit
import SwiftSpinner

class PokemonDetailViewController: UIViewController {

    var pokemon: Pokemon!
  
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var pokedexIdLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var nextEvolutionLabel: UILabel!
    @IBOutlet weak var currentEvolution: UIImageView!
    @IBOutlet weak var nextEvolution: UIImageView!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftSpinner.show("Aguarde...", animated: true)
    }
  
  override func viewWillAppear(_ animated: Bool) {
    nameLabel.text = pokemon.name
    let img = UIImage(named: "\(pokemon.pokedexId)")
    pokemonImage.image = img
    
    currentEvolution.image = img
    
    pokemon.downloadPokemonDetails {
      self.updateUI()
      SwiftSpinner.hide()
    }
  }
  
    func updateUI() {
      pokedexIdLabel.text = "\(pokemon.pokedexId)"
      descriptionLabel.text = pokemon.description
      typeLabel.text = pokemon.type
      defenseLabel.text = pokemon.defense
      weightLabel.text = pokemon.weight
      heightLabel.text = pokemon.height
      attackLabel.text = pokemon.attack
      
      pokemonImage.isHidden = false
      descriptionLabel.isHidden = false
      currentEvolution.isHidden = false
      
      if pokemon.nextEvolutionPokedexId == "" {
        nextEvolutionLabel.text = "No evolutions"
        nextEvolution.isHidden = true
      } else {
        nextEvolution.isHidden = false
        nextEvolution.image = UIImage(named: pokemon.nextEvolutionPokedexId)
        nextEvolutionLabel.text = "Next evolution: \(pokemon.nextEvolutionName)"
      }
    }
  
    @IBAction func backButtonTapped(_ sender: AnyObject) {
      descriptionLabel.isHidden = true
      currentEvolution.isHidden = true
      nextEvolution.isHidden = true
      pokemonImage.isHidden = true
      dismiss(animated: true, completion: nil)
    }
}
