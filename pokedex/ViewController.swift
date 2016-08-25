//
//  ViewController.swift
//  pokedex
//
//  Created by Marco Rojo on 31/07/16.
//  Copyright © 2016 Marco Rojo. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
  
  @IBOutlet weak var collection: UICollectionView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  var pokemons = [Pokemon]()
  var filteredPokemons = [Pokemon]()
  var musicPlayer: AVAudioPlayer!
  var inSearchMode = false
  

  override func viewDidLoad() {
    super.viewDidLoad()
    
    collection.delegate = self
    collection.dataSource = self
    searchBar.delegate = self
    
    searchBar.returnKeyType = UIReturnKeyType.done
    
    initAudio()
    parsePokemomnCSV()
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
      
      let pokemon: Pokemon
      
      if inSearchMode {
        pokemon = filteredPokemons[indexPath.row]
      } else {
        pokemon = pokemons[indexPath.row]
      }
      
      cell.configureCell(pokemon)
      
      return cell
    } else {
      return UICollectionViewCell()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let pokemon: Pokemon!
    if inSearchMode {
      pokemon = filteredPokemons[indexPath.row]
    } else {
      pokemon = pokemons[indexPath.row]
    }
    
    performSegue(withIdentifier: "PokemonDetailViewController", sender: pokemon)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if inSearchMode {
      return filteredPokemons.count
    }
    
    return pokemons.count
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchBar.text == nil || searchBar.text == "" {
      inSearchMode = false
      view.endEditing(true)
      collection.reloadData()
    } else {
      inSearchMode = true
      let lower = searchBar.text!.lowercased()
      filteredPokemons = pokemons.filter({$0.name.range(of: lower) != nil})
      collection.reloadData()
    }
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    view.endEditing(true)
  }
  
  
  @IBAction func musicButtonPressed(_ sender: UIButton!) {
    if musicPlayer.isPlaying {
      sender.alpha = 0.5
      musicPlayer.stop()
    } else {
      sender.alpha = 1.0
      musicPlayer.play()
    }
  }
  
  func initAudio() {
    let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
    do {
      musicPlayer = try AVAudioPlayer(contentsOf: NSURL(string: path)! as URL)
      musicPlayer.prepareToPlay()
      musicPlayer.numberOfLoops = -1
      musicPlayer.play()
    } catch let err as NSError {
      print(err.debugDescription)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "PokemonDetailViewController" {
      let viewController = segue.destination as? PokemonDetailViewController
      let pokemon = sender as? Pokemon
      viewController?.pokemon = pokemon
      
      
    }
  }
}
