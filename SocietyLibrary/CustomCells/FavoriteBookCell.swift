//
//  FavoriteBookCell.swift
//  SocietyLibrary
//
//  Created by Tia Lendor on 10/18/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import UIKit

class FavoriteBookCell: UICollectionViewCell {
    
    weak var delegate: BookCellDelegate?
    
    lazy var faveBookImage: UIImageView = {
        let favedImage = UIImageView()
        return favedImage
    }()
    
    lazy var bookSummary: UITextView = {
        var summary = UITextView()
        summary.backgroundColor = .orange
        return summary
    }()
    
    lazy var weeksAtTop: UILabel = {
        var topWeeks = UILabel()
        return topWeeks
    }()
    
    lazy var actionButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(showActionS(_:)), for: .touchUpInside)
        return button
    }()
    
  
        
    @objc func showActionS (_ sender: UIButton) {
        delegate?.showActionSheet(tag: sender.tag)
        }
//                try? book.permanager.delete(element: self.photoJournal, atIndex: tag)
//                self.loadJournal()
//            }
//            let editAction = UIAlertAction(title: "Edit", style: .default) { (action) in
//                let alert = UIAlertController(title: "", message: "I DO NOT KNOW HOW TO EDIT", preferredStyle: .alert)
//                let action = UIAlertAction(title: "OK", style: .destructive, handler: nil)
//                alert.addAction(action)
//                self.present(alert, animated: true)
//            }
//            let shareAction = UIAlertAction(title: "Share", style: .default) { (action) in
//                let alert = UIAlertController(title: "", message: "I DO NOT KNOW HOW TO SHARE", preferredStyle: .alert)
//                let action = UIAlertAction(title: "OK", style: .destructive, handler: nil)
//                alert.addAction(action)
//                self.present(alert, animated: true)
//            }
//            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
//            }
//            alert.addAction(destroyAction)
//            alert.addAction(editAction)
//            alert.addAction(shareAction)
//            alert.addAction(cancelAction)
//            self.present(alert, animated: true) {
//            }
//        }

    
    
//    lazy var externalURL:
    /*
     let amazonURL: String
     */
    
//    lazy var favedStackView: UIStackView = {
//        let favedStack = UIStackView(arrangedSubviews: [faveBookImage, weeksAtTop, bookSummary])
//        favedStack.axis = .vertical
//        favedStack.alignment = .center
//        favedStack.distribution = .fillProportionally
//        favedStack.spacing = 5
//        return favedStack
//    }()
    
    func addSubviews() {
        addSubview(faveBookImage)
        addSubview(weeksAtTop)
        addSubview(bookSummary)
        addSubview(actionButton)
        
      
    }
    
    
    func constrain() {
        
        faveBookImage.translatesAutoresizingMaskIntoConstraints = false
        [faveBookImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 50),
         faveBookImage.heightAnchor.constraint(equalToConstant: 100),
         faveBookImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
         faveBookImage.widthAnchor.constraint(equalToConstant: 100)].forEach{ $0.isActive = true }
        
       weeksAtTop.translatesAutoresizingMaskIntoConstraints = false
       [weeksAtTop.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
        weeksAtTop.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)].forEach{ $0.isActive = true }
        
        bookSummary.translatesAutoresizingMaskIntoConstraints = false
        [bookSummary.topAnchor.constraint(equalTo: weeksAtTop.bottomAnchor),
         bookSummary.heightAnchor.constraint(equalToConstant: 200),
         bookSummary.widthAnchor.constraint(equalToConstant: 200),
         bookSummary.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)].forEach{ $0.isActive = true }
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        [actionButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
         actionButton.leadingAnchor.constraint(equalTo: faveBookImage.trailingAnchor, constant: 20),
        actionButton.widthAnchor.constraint(equalToConstant: 50),
            actionButton.heightAnchor.constraint(equalToConstant: 50)].forEach{ $0.isActive = true }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .white
        addSubviews()
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
