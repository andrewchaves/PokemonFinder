//
//  PokemonType.swift
//  Pokemon
//
//  Created by Andrew Chaves on 06/12/19.
//  Copyright © 2019 Andrew Chaves. All rights reserved.
//

import UIKit

import ObjectMapper

class PokemonType: Mappable {
    var name: String?
    var thumbnailImage: String?
    
    required init?(map: Map){

    }
    
    func mapping(map: Map) {
        name <- map["name"]
        thumbnailImage <- map["thumbnailImage"]
    }
}
