//
//  PokemonViewCell.swift
//  Pokedex
//
//  Created by Juliano Sgarbossa on 16/06/25.
//

import UIKit
import Kingfisher

class PokemonViewCell: UIView {
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, numberLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setVisualElements() {
        addSubview(contentView)
        contentView.addSubview(pokemonImageView)
        contentView.addSubview(infoStackView)
        
        self.setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            
            pokemonImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            pokemonImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            pokemonImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 90),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 90),
            
            infoStackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            infoStackView.leadingAnchor.constraint(equalTo: self.pokemonImageView.trailingAnchor, constant: 15),
            infoStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10)
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
