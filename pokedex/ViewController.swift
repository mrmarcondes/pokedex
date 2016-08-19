//
//  ViewController.swift
//  pokedex
//
//  Created by Marco Rojo on 31/07/16.
//  Copyright © 2016 Marco Rojo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  
  @IBOutlet weak var collection: UICollectionView!
  
  var pokemons = [Pokemon]()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    collection.delegate = self
    collection.dataSource = self
    
    parsePokemomnCSV()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func parsePokemomnCSV() {
    let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
    
    do {
      let csv = try CSV(contentsOfURL: path)
      let rows = csv.rows
    
      for row in rows {
        let id = Int(row["id"]!)!
        let name = row["identifier"]!
        let pokemon = Pokemon(name: name, pokedexId: id)
        pokemons.append(pokemon)
      }
      
      
    } catch let err as NSError {
      print(err.debugDescription)
    }
    
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as? PokeCell {
      
      let pokemon = pokemons[indexPath.row]
      cell.configureCell(pokemon: pokemon)
      
      return cell
    } else {
      return UICollectionViewCell()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 718
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  

}

