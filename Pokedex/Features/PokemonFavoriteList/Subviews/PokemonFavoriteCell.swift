//
//  PokemonFavoriteCell.swift
//  Pokedex
//
//  Created by Juliano Sgarbossa on 23/06/25.
//

import UIKit
import Kingfisher

class PokemonFavoriteCell: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColor.neutralLightGray
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.05
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 2
        view.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
        view.layer.borderWidth = 0.5
        view.clipsToBounds = true
        return view
    }()
    
    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = AppColor.neutralDarkGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setVisualElements() {
        addSubview(containerView)
        containerView.addSubview(pokemonImageView)
        containerView.addSubview(nameLabel)
        
        self.setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            pokemonImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            pokemonImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            pokemonImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            pokemonImageView.heightAnchor.constraint(equalTo: pokemonImageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            nameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
        ])
    }
    
    func configViewCell(pokemon: Pokemon) {
        let pokemonImageUrl = URL(string: pokemon.pokemonImage)
        self.pokemonImageView.kf.setImage(with: pokemonImageUrl, placeholder: UIImage(named: AppString.Image.pokemonImageDefault))
        self.nameLabel.text = pokemon.name
    }
}
