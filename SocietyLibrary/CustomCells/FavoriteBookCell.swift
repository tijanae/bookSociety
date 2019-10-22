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

/*
func showActionSheet(tag: Int) {
       let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
       let destroyAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
           try? EntryPersistenceHelper.manager.delete(element: self.photoJournal, atIndex: tag)
           self.loadJournal()
       }
       let editAction = UIAlertAction(title: "Edit", style: .default) { (action) in
           let alert = UIAlertController(title: "", message: "I DO NOT KNOW HOW TO EDIT", preferredStyle: .alert)
           let action = UIAlertAction(title: "OK", style: .destructive, handler: nil)
           alert.addAction(action)
           self.present(alert, animated: true)
       }
       let shareAction = UIAlertAction(title: "Share", style: .default) { (action) in
           let alert = UIAlertController(title: "", message: "I DO NOT KNOW HOW TO SHARE", preferredStyle: .alert)
           let action = UIAlertAction(title: "OK", style: .destructive, handler: nil)
           alert.addAction(action)
           self.present(alert, animated: true)
       }
       let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
       }
       alert.addAction(destroyAction)
       alert.addAction(editAction)
       alert.addAction(shareAction)
       alert.addAction(cancelAction)
       self.present(alert, animated: true) {
       }
   }
}
*/
