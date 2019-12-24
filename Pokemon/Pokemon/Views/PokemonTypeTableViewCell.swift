//
//  ItemTableViewCell.swift
//  Peixe Urbano
//
//  Created by Andrew Chaves on 06/12/19.
//  Copyright © 2019 Andrew Chaves. All rights reserved.
//

import UIKit

class PokemonTypeTableViewCell: UITableViewCell {
    
    var ptImage = UIImageView()
    var ptName = UILabel()
    var ptCheckButton = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpCell(pokemonTypeVM:PokemonTypeViewModel) {
        
        ptImage.downloaded(from: pokemonTypeVM.thumbnailImage!)
        ptImage.contentMode = .scaleAspectFit
        ptImage.clipsToBounds = true
        contentView.addSubview(ptImage)
        ptImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 0, width: 0, height: 0, enableInsets: false)

        ptName.text = pokemonTypeVM.name
        ptName.textColor = .black
        ptName.font = UIFont.boldSystemFont(ofSize: 20.0)
        contentView.addSubview(ptName)
        ptName.anchor(top: topAnchor, left: ptImage.leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 4, paddingLeft: 100 , paddingBottom: 4, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        var radioImage:UIImage!
        if pokemonTypeVM.checked {
            radioImage = UIImage(named: "radio-on")
        } else {
            radioImage = UIImage(named: "radio-off")
        }
        ptCheckButton.image = radioImage
        ptCheckButton.contentMode = .scaleAspectFit
        contentView.addSubview(ptCheckButton)
        ptCheckButton.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 8, width: 0, height: 0, enableInsets: false)

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
