//
//  Pokemon.swift
//  Pokemon
//
//  Created by Andrew Chaves on 06/12/19.
//  Copyright © 2019 Andrew Chaves. All rights reserved.
//

import UIKit

class PokemonViewModel: NSObject {
    
    var name: String?
    var thumbnailImage: String?
    var type = [String]()
    
    init(pokemon:Pokemon) {
        self.name = pokemon.name!.capitalizingFirstLetter()
        self.thumbnailImage = pokemon.thumbnailImage!
        for type in pokemon.type {
            self.type.append(type.capitalizingFirstLetter())
        }
    }

}
