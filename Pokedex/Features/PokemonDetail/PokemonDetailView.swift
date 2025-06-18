//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Juliano Sgarbossa on 16/06/25.
//

import UIKit

class PokemonDetailView: UIView {
    
    private let headerNavigationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemOrange
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        scrollView.bounces = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemOrange
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var pokemonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pokemonImageView, pokemonNameLabel, pokemonInfoStackView, favoriteButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "psyduck") // koffing psyduck
        return imageView
    }()
    
    private let pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Psyduck"
        return label
    }()
    
    private lazy var pokemonInfoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [heightLabel, weightLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let heightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.text = "Height: 0,7m"
        return label
    }()
    
    private let weightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.text = "Weight: 6,9kg"
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "heart.fill")
        config.imagePadding = 8
        config.imagePlacement = .leading
        let button = UIButton(configuration: config, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemRed
        let title = NSAttributedString(string: "Favoritar", attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ])
        button.setAttributedTitle(title, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        return button
    }()
    
    private let footterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let typesScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = true
        return scrollView
    }()
    
    private let typesContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let typesStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .center
        return stack
    }()
    
    private let baseStatsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.textColor = .black
        label.text = "Status Base"
        return label
    }()
    
    private lazy var statsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [attackPokemonStatView, spAttackPokemonStatView, speedPokemonStatView, hpPokemonStatView, defensePokemonStatView, spDefensePokemonStatView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 15
        return stack
    }()
    
    private let attackPokemonStatView: PokemonStatView = {
        let pokemonStatView = PokemonStatView()
        pokemonStatView.configure(statName: "Attack", value: 49)
        return pokemonStatView
    }()
    
    private let spAttackPokemonStatView: PokemonStatView = {
        let pokemonStatView = PokemonStatView()
        pokemonStatView.configure(statName: "Sp. Atk", value: 65)
        return pokemonStatView
    }()
    
    private let speedPokemonStatView: PokemonStatView = {
        let pokemonStatView = PokemonStatView()
        pokemonStatView.configure(statName: "Speed", value: 45)
        return pokemonStatView
    }()
    
    private let hpPokemonStatView: PokemonStatView = {
        let pokemonStatView = PokemonStatView()
        pokemonStatView.configure(statName: "HP", value: 45)
        return pokemonStatView
    }()
    
    private let defensePokemonStatView: PokemonStatView = {
        let pokemonStatView = PokemonStatView()
        pokemonStatView.configure(statName: "Defense", value: 49)
        return pokemonStatView
    }()
    
    private let spDefensePokemonStatView: PokemonStatView = {
        let pokemonStatView = PokemonStatView()
        pokemonStatView.configure(statName: "Sp. Def", value: 105)
        return pokemonStatView
    }()
    
    @objc
    private func favoriteTapped(sender: UIButton) {
        print("Pokemon Favoritado!")
    }
    
    func configureTypes(_ types: [String]) {
        typesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for type in types {
            let label = UILabel()
            label.text = type.capitalized
            label.font = .boldSystemFont(ofSize: 14)
            label.textColor = .white
            label.backgroundColor = color(for: type)
            label.textAlignment = .center
            label.layer.cornerRadius = 20
            label.clipsToBounds = true
            label.setContentHuggingPriority(.required, for: .horizontal)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.heightAnchor.constraint(equalToConstant: 40).isActive = true
            label.widthAnchor.constraint(greaterThanOrEqualToConstant: 150).isActive = true
            typesStackView.addArrangedSubview(label)
        }
    }

    private func color(for type: String) -> UIColor {
        switch type.lowercased() {
        case "fire": return .systemRed
        case "water": return .systemBlue
        case "grass": return .systemGreen
        case "poison": return .systemPurple
        case "flying": return .systemTeal
        case "electric": return .systemYellow
        default: return .gray
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
        addSubview(headerNavigationView)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(headerView)
        headerView.addSubview(pokemonStackView)
        contentView.addSubview(footterView)
        footterView.addSubview(typesScrollView)
        typesScrollView.addSubview(typesContentView)
        typesContentView.addSubview(typesStackView)
        footterView.addSubview(baseStatsTitleLabel)
        footterView.addSubview(statsStackView)
        self.setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            headerNavigationView.topAnchor.constraint(equalTo: topAnchor),
            headerNavigationView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerNavigationView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerNavigationView.heightAnchor.constraint(equalToConstant: 225),
            
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            headerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            pokemonStackView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            pokemonStackView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            pokemonStackView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            pokemonStackView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20),
            
            pokemonImageView.widthAnchor.constraint(equalToConstant: 200),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 200),
            
            favoriteButton.heightAnchor.constraint(equalToConstant: 40),

            footterView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            footterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            footterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            footterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
  
            typesScrollView.topAnchor.constraint(equalTo: footterView.topAnchor, constant: 15),
            typesScrollView.leadingAnchor.constraint(equalTo: footterView.leadingAnchor),
            typesScrollView.trailingAnchor.constraint(equalTo: footterView.trailingAnchor),
            typesScrollView.heightAnchor.constraint(equalToConstant: 40),
            
            typesContentView.topAnchor.constraint(equalTo: typesScrollView.topAnchor),
            typesContentView.bottomAnchor.constraint(equalTo: typesScrollView.bottomAnchor),
            typesContentView.leadingAnchor.constraint(equalTo: typesScrollView.leadingAnchor),
            typesContentView.trailingAnchor.constraint(equalTo: typesScrollView.trailingAnchor),
            typesContentView.heightAnchor.constraint(equalTo: typesScrollView.heightAnchor),
            typesContentView.widthAnchor.constraint(greaterThanOrEqualTo: typesStackView.widthAnchor),
            typesContentView.widthAnchor.constraint(equalTo: typesScrollView.widthAnchor).withPriority(.defaultLow),

            typesStackView.topAnchor.constraint(equalTo: typesContentView.topAnchor),
            typesStackView.bottomAnchor.constraint(equalTo: typesContentView.bottomAnchor),
            typesStackView.centerXAnchor.constraint(equalTo: typesContentView.centerXAnchor),
            
            baseStatsTitleLabel.topAnchor.constraint(equalTo: typesScrollView.bottomAnchor, constant: 15),
            baseStatsTitleLabel.leadingAnchor.constraint(equalTo: footterView.leadingAnchor, constant: 20),
            baseStatsTitleLabel.trailingAnchor.constraint(equalTo: footterView.trailingAnchor, constant: -20),
            
            statsStackView.topAnchor.constraint(equalTo: baseStatsTitleLabel.bottomAnchor, constant: 15),
            statsStackView.leadingAnchor.constraint(equalTo: footterView.leadingAnchor, constant: 20),
            statsStackView.trailingAnchor.constraint(equalTo: footterView.trailingAnchor, constant: -20),
            statsStackView.bottomAnchor.constraint(equalTo: footterView.bottomAnchor, constant: -20),
        ])
    }
}

extension NSLayoutConstraint {
    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
