//
//  MuiltiSectionViewController.swift
//  UICollectionViewTour
//
//  Created by Giovanni Noa on 12/19/19.
//  Copyright © 2019 ivancr. All rights reserved.
//

import Foundation
import UIKit

class CustomCell: UICollectionViewCell {
    fileprivate let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "TheWire_Season_1")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MultiSectionViewController: UIViewController {
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width - 32, height: 180)
        let spacing = CGFloat(16)
        layout.sectionInset = UIEdgeInsets(top: spacing,
                                           left: spacing,
                                           bottom: spacing,
                                           right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        return layout
    }()
    
    private let firstLabel: UILabel = {
        let label = UILabel()
        label.text = "    Section 1"
        label.font = UIFont.preferredFont(for: .title3, weight: .bold)
        label.textColor = .systemGray
        return label
    }()
    
    fileprivate lazy var firstCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var firstStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstLabel, firstCollectionView])
        stackView.axis = .vertical
        return stackView
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.text = "    Section 2"
        label.font = UIFont.preferredFont(for: .title3, weight: .bold)
        label.textColor = .systemGray
        return label
    }()
    
    fileprivate lazy var secondCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    
    private lazy var secondStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [secondLabel, secondCollectionView])
        stackView.axis = .vertical
        return stackView
    }()
    
    fileprivate lazy var thirdCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let thirdLabel: UILabel = {
        let label = UILabel()
        label.text = "    Section 3"
        label.font = UIFont.preferredFont(for: .title3, weight: .bold)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var thirdStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [thirdLabel, thirdCollectionView])
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: - StackView container
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstStackView, secondStackView, thirdStackView])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Multi-Section Flow"
        
        view.backgroundColor = .systemBackground
        
        firstCollectionView.delegate = self
        firstCollectionView.dataSource = self
        
        secondCollectionView.delegate = self
        secondCollectionView.dataSource = self
        
        thirdCollectionView.delegate = self
        thirdCollectionView.dataSource = self
        
        view.addSubview(stackView)
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: safeArea.bottomAnchor),
            
            thirdStackView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.3),
            firstStackView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.3),
            secondStackView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.3),
        ])
    }
}

extension MultiSectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        return cell
    }
}
