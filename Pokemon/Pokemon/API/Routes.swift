//
//  Routes.swift
//  Pokemon
//
//  Created by Andrew Chaves on 06/12/19.
//  Copyright © 2019 Andrew Chaves. All rights reserved.
//

import UIKit

class Routes{
    
    static let shared = Routes()
    
    init(){}
    
    func getPokemonTypeUrl() -> String{
        return "https://vortigo.blob.core.windows.net/files/pokemon/data/types.json"
    }
    
    func getPokemonsUrl() -> String{
        return "https://vortigo.blob.core.windows.net/files/pokemon/data/pokemons.json"
    }
    
}

