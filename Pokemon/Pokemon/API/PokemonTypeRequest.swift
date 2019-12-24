//
//  Requests.swift
//  Pokemon
//
//  Created by Andrew Chaves on 06/12/19.
//  Copyright © 2019 Andrew Chaves. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class PokemonTypeRequest: NSObject {
    
    func fetchPokemonTypes(completion: @escaping ([PokemonType]?) -> Void) {
        AF.request(Routes.shared.getPokemonTypeUrl()).responseArray(keyPath:"results") { (response: AFDataResponse<[PokemonType]>) in
            
            switch response.result {
               case .success(let value):
                completion(value)
            case .failure( _):
                completion(nil)
            }
           
        }
    }

}
