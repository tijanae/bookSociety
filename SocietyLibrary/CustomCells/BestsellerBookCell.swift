//
//  BestsellerBookCell.swift
//  SocietyLibrary
//
//  Created by Tia Lendor on 10/18/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import UIKit

class BestsellerBookCell: UICollectionViewCell {
    lazy var bookImage: UIImageView = {
        let bookImage = UIImageView()
        bookImage.image = UIImage(named: "logo")
        return bookImage
        
    }()
    
    lazy var bookName: UILabel = {
        var bookName = UILabel()
        bookName.textAlignment = .center
        bookName.font = UIFont.systemFont(ofSize: 12)
        return bookName
    }()
    
    lazy var bookText: UITextView = {
        let bookText = UITextView()
        bookText.isEditable = false
        bookText.sizeToFit()
        bookText.isScrollEnabled = true
        bookText.font = UIFont.systemFont(ofSize: 15)
        return bookText
    }()
    
    private func addViews(){
        contentView.addSubview(bookImage)
        contentView.addSubview(bookName)
        contentView.addSubview(bookText)
        
    }
    private func addConstraints(){
        constrainImageView()
        constrainBookName()
        constrainBookText()
    }
    private func constrainImageView(){
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        [bookImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11),
         bookImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 44),
         bookImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.50),
         bookImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -44)
            ].forEach{$0.isActive = true}
    }
    
    private func constrainBookName(){
        bookName.translatesAutoresizingMaskIntoConstraints = false
        bookName.topAnchor.constraint(equalTo: bookImage.bottomAnchor).isActive = true
        bookName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CGFloat(11)).isActive = true
        bookName.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.10).isActive = true
        bookName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -11).isActive = true
    }
    private func constrainBookText(){
        bookText.translatesAutoresizingMaskIntoConstraints = false
        [bookText.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -30),
         bookText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
         bookText.topAnchor.constraint(equalTo: bookName.bottomAnchor, constant: 0),
         bookText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
            ].forEach{$0.isActive = true}
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        addConstraints()
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
