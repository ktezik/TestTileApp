//
//  CollectionView.swift
//  GrishinTest
//
//  Created by Иван Гришин on 14.03.2024.
//

import UIKit

final class CollectionView: UICollectionView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let cellSize: CGSize = .init(width: 80, height: 80)
        static let contentInsets: UIEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    // MARK: - Overridden Properties
    
    override var intrinsicContentSize: CGSize {
        .init(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }
    
    // MARK: - Private Properties
    
    private var collectionTypeModel: CollectionTypeModel
    
    // MARK: - Initializer
    
    init(collectionTypeModel: CollectionTypeModel) {
        self.collectionTypeModel = collectionTypeModel
        let collectionLayout = UICollectionViewFlowLayout()
        if case .innerCollection = collectionTypeModel {
            collectionLayout.scrollDirection = .horizontal
        }
        super.init(frame: .zero, collectionViewLayout: collectionLayout)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func update(model: CollectionTypeModel) {
        collectionTypeModel = model
        switch collectionTypeModel {
        case .outerCollection(let outerModel):
            indexPathsForVisibleItems.forEach { index in
                guard outerModel.indices.contains(index.item) else { return }
                guard let cell = cellForItem(at: index) as? OuterCollectionViewCell else { return }
                cell.updateInnerCollection(model: .innerCollection(outerModel[index.item]))
            }
        case .innerCollection(let innerModel):
            indexPathsForVisibleItems.forEach { index in
                guard innerModel.indices.contains(index.item) else { return }
                guard let cell = cellForItem(at: index) as? InnerCollectionViewCell else { return }
                cell.configureCell(with: innerModel[index.item])
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func setupCollectionView() {
        setupInsets()
        registerCell()
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
        delegate = self
        dataSource = self
    }
    
    private func setupInsets() {
        guard case .innerCollection = collectionTypeModel else { return }
        contentInset = Constants.contentInsets
    }
    
    private func registerCell() {
        switch collectionTypeModel {
        case .outerCollection:
            register(cell: OuterCollectionViewCell.self)
        case .innerCollection:
            register(cell: InnerCollectionViewCell.self)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        switch collectionTypeModel {
        case .outerCollection:
            return CGSize(width: collectionView.bounds.width, height: Constants.cellSize.height)
        case .innerCollection:
            return Constants.cellSize
        }
    }
}

// MARK: - UICollectionViewDataSource

extension CollectionView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch collectionTypeModel {
        case .outerCollection(let model):
            let cell: OuterCollectionViewCell = collectionView.dequeueCell(for: indexPath)
            cell.configureCell(with: .innerCollection(model[indexPath.item]))
            return cell
        case .innerCollection(let model):
            let cell: InnerCollectionViewCell = collectionView.dequeueCell(for: indexPath)
            cell.configureCell(with: model[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionTypeModel {
        case .outerCollection(let model):
            return model.count
        case .innerCollection(let model):
            return model.count
        }
    }
}

