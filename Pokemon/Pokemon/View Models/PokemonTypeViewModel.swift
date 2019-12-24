//
//  PokemonTypeViewModel.swift
//  Pokemon
//
//  Created by Andrew Chaves on 06/12/19.
//  Copyright © 2019 Andrew Chaves. All rights reserved.
//

import UIKit

class PokemonTypeViewModel: NSObject {
    
    var name: String?
    var thumbnailImage: String?
    var checked: Bool!
    
    init(pokemonType:PokemonType, checked: Bool) {
        self.name = pokemonType.name!.capitalizingFirstLetter()
        self.thumbnailImage = pokemonType.thumbnailImage!
        self.checked = checked
    }

}
