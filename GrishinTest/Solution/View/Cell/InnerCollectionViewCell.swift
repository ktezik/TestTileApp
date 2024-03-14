//
//  InnerCollectionViewCell.swift
//  GrishinTest
//
//  Created by Иван Гришин on 14.03.2024.
//

import UIKit

final class InnerCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let borderWidth: CGFloat = 2
        static let cellRadius: CGFloat = 12
    }
    
    // MARK: - Private Properties
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.minimumScaleFactor = 0.2
        label.font = .systemFont(ofSize: 25)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overridden Methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.2) {
            self.transform = .identity
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.2) {
            self.transform = .identity
        }
    }
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        valueLabel.text = nil
    }
    
    // MARK: - Public Methods
    
    func configureCell(with model: Model) {
        valueLabel.text = String(model.randomValue)
    }
    
    // MARK: - Private Methods
    
    private func setupCell() {
        contentView.layer.borderWidth = Constants.borderWidth
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.cornerRadius = Constants.cellRadius
        contentView.layer.cornerCurve = .continuous
        configureLayout()
    }
    
    private func configureLayout() {
        contentView.addSubview(valueLabel)
        NSLayoutConstraint.activate([
            valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
