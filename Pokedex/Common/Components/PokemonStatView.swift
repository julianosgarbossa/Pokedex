//
//  PokemonStatView.swift
//  Pokedex
//
//  Created by Juliano Sgarbossa on 18/06/25.
//

import UIKit

class PokemonStatView: UIView {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [statNameLabel, statValueLabel, progressView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 15
        return stackView
    }()
    
    private let statNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private let statValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.trackTintColor = .systemGray5
        progress.progressTintColor = .systemGreen
        progress.layer.cornerRadius = 2
        progress.clipsToBounds = true
        return progress
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setVisualElements() {
        addSubview(stackView)
        
        statNameLabel.setContentHuggingPriority(.required, for: .horizontal)
        statValueLabel.setContentHuggingPriority(.required, for: .horizontal)
        progressView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        progressView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            progressView.heightAnchor.constraint(equalToConstant: 4),
            statNameLabel.widthAnchor.constraint(equalToConstant: 60),
            statValueLabel.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    func configure(statName: String, value: Int) {
        statNameLabel.text = statName
        statValueLabel.text = "\(value)"
        progressView.progress = Float(value) / 255.0
        
        switch value {
        case 0..<60:
            progressView.progressTintColor = .systemRed
        case 60..<100:
            progressView.progressTintColor = .systemOrange
        default:
            progressView.progressTintColor = .systemGreen
        }
    }
}
