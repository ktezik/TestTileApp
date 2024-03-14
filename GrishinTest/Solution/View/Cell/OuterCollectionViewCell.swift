//
//  OuterCollectionViewCell.swift
//  GrishinTest
//
//  Created by Иван Гришин on 14.03.2024.
//

import UIKit

final class OuterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Private Properties
    
    private var innerCollectionView: CollectionView?
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        innerCollectionView?.removeFromSuperview()
        innerCollectionView = nil
    }
    
    // MARK: - Public Properties
    
    func updateInnerCollection(model: CollectionTypeModel) {
        innerCollectionView?.update(model: model)
    }
    
    func configureCell(with type: CollectionTypeModel) {
        innerCollectionView = CollectionView(collectionTypeModel: type)
        guard let innerCollectionView else { return }
        innerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(innerCollectionView)
        NSLayoutConstraint.activate([
            innerCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            innerCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            innerCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            innerCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
