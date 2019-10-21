//
//  FavoriteBookCell.swift
//  SocietyLibrary
//
//  Created by Tia Lendor on 10/18/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import UIKit

class FavoriteBookCell: UICollectionViewCell {
    
    lazy var faveBookImage: UIImageView = {
        let favedImage = UIImageView()
        return favedImage
    }()
    
    lazy var bookSummary: UITextView = {
        var summary = UITextView()
        return summary
    }()
    
    lazy var weeksAtTop: UILabel = {
        var topWeeks = UILabel()
        return topWeeks
    }()
    
    
    
//    lazy var externalURL:
    /*
     let imageName: String
     let imageData: Data
     let summary: String
     let amazonURL: String
    
     */
    
    lazy var favedStackView: UIStackView = {
        let favedStack = UIStackView(arrangedSubviews: [faveBookImage, weeksAtTop, bookSummary])
        favedStack.axis = .vertical
        favedStack.alignment = .center
        favedStack.distribution = .fillProportionally
        favedStack.spacing = 5
        return favedStack
    }()
    
    
    func constrain() {
        favedStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favedStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            favedStackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            favedStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            favedStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(favedStackView)
        constrain()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
