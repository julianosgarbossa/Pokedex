//
//  PokemonViewCell.swift
//  Pokedex
//
//  Created by Juliano Sgarbossa on 16/06/25.
//

import UIKit
import Kingfisher

class PokemonViewCell: UIView {
    
    private let backgroundEffectsContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 240/255, green: 241/255, blue: 243/255, alpha: 1)
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.05
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 2
        view.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    private let infoBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 36/255, green: 39/255, blue: 41/255, alpha: 1)
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        return view
    }()
    
    private let imageBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 240/255, green: 241/255, blue: 243/255, alpha: 1)
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [numberLabel, nameLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(red: 255/255, green: 204/255, blue: 0, alpha: 1)
        return label
    }()
    
    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.infoBackgroundView.applyDiagonalMask(cutoffMultiplier: 0.75)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setVisualElements() {
        addSubview(backgroundEffectsContentView)
        backgroundEffectsContentView.addSubview(infoBackgroundView)
        backgroundEffectsContentView.addSubview(imageBackgroundView)
        infoBackgroundView.addSubview(infoStackView)
        imageBackgroundView.addSubview(pokemonImageView)
        
        self.setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundEffectsContentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            backgroundEffectsContentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            backgroundEffectsContentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            backgroundEffectsContentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            
            infoBackgroundView.topAnchor.constraint(equalTo: backgroundEffectsContentView.topAnchor),
            infoBackgroundView.leadingAnchor.constraint(equalTo: backgroundEffectsContentView.leadingAnchor),
            infoBackgroundView.bottomAnchor.constraint(equalTo: backgroundEffectsContentView.bottomAnchor),
            infoBackgroundView.trailingAnchor.constraint(equalTo: imageBackgroundView.leadingAnchor),
            
            imageBackgroundView.topAnchor.constraint(equalTo: backgroundEffectsContentView.topAnchor),
            imageBackgroundView.trailingAnchor.constraint(equalTo: backgroundEffectsContentView.trailingAnchor),
            imageBackgroundView.bottomAnchor.constraint(equalTo: backgroundEffectsContentView.bottomAnchor),
            imageBackgroundView.widthAnchor.constraint(equalTo: backgroundEffectsContentView.widthAnchor, multiplier: 0.3),
            
            infoStackView.centerYAnchor.constraint(equalTo: infoBackgroundView.centerYAnchor),
            infoStackView.leadingAnchor.constraint(equalTo: infoBackgroundView.leadingAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: infoBackgroundView.trailingAnchor, constant: -8),
            
            pokemonImageView.centerXAnchor.constraint(equalTo: imageBackgroundView.centerXAnchor),
            pokemonImageView.centerYAnchor.constraint(equalTo: imageBackgroundView.centerYAnchor),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 90),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    func prepareForReuse() {
        self.pokemonImageView.image = nil
        self.nameLabel.text = nil
        self.numberLabel.text = nil
    }
    
    func configViewCell(pokemon: Pokemon) {
        let pokemonImageUrl = URL(string: pokemon.pokemonImage)
        self.pokemonImageView.kf.setImage(with: pokemonImageUrl, placeholder: UIImage(named: "pokemonImageDefault"))
        self.nameLabel.text = pokemon.name
        self.numberLabel.text = String(format: "#%03d", pokemon.number)
    }
}
