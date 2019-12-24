//
//  PokemonRequest.swift
//  Pokemon
//
//  Created by Andrew Chaves on 06/12/19.
//  Copyright © 2019 Andrew Chaves. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class PokemonRequest: NSObject {
    
    func fetchPokemons(completion: @escaping ([Pokemon]?) -> Void) {
        AF.request(Routes.shared.getPokemonsUrl()).responseArray { (response: AFDataResponse<[Pokemon]>) in
            switch response.result {
               case .success(let value):
                completion(value)
            case .failure( _):
                completion(nil)
            }
        }
    }

}
