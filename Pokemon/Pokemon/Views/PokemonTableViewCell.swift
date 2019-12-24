//
//  PokemonTableViewCell.swift
//  Pokemon
//
//  Created by Andrew Chaves on 06/12/19.
//  Copyright © 2019 Andrew Chaves. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    var pImage = UIImageView()
    var pName = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpCell(pokemonVM:PokemonViewModel) {
        
        pImage.downloaded(from: pokemonVM.thumbnailImage!)
        pImage.contentMode = .scaleAspectFit
        pImage.clipsToBounds = true
        contentView.addSubview(pImage)
        pImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 0, width: 70, height: 0, enableInsets: false)

        pName.text = pokemonVM.name
        pName.textColor = .black
        pName.font = UIFont.boldSystemFont(ofSize: 20.0)
        contentView.addSubview(pName)
        pName.anchor(top: topAnchor, left: pImage.leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 4, paddingLeft: 90 , paddingBottom: 4, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

