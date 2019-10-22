//
//  FavoriteVC.swift
//  SocietyLibrary
//
//  Created by Tia Lendor on 10/18/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import UIKit


class FavoriteVC: UIViewController {
    
    var favedBooks = [FavoriteBooks]() {
        didSet {
            favedBooksCollectionView.reloadData()
            print(self.favedBooks.count)
        }
    }
    
    
    lazy var favedBooksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let faveCV = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
            
//            UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        faveCV.backgroundColor = .purple
        faveCV.register(FavoriteBookCell.self, forCellWithReuseIdentifier: "faveCell")
        
//        faveCV.dataSource = self
//        faveCV.delegate = self
        return faveCV
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setDelegates()
        loadData()
        constrainFavedCollection()
        // Do any additional setup after loading the view.
    }
    
    
    private func setDelegates() {
        favedBooksCollectionView.delegate = self
        favedBooksCollectionView.dataSource = self
    }
    
    private func setUpView() {
        self.navigationItem.title = "Favorited Bestsellers"
        view.backgroundColor = .white
    }
    
    func loadData() {
        do {
        favedBooks = try BookPersistenceManager.manager.getFavorites()
        } catch {
            fatalError("could not get favorites")
        }
    }

    private func constrainFavedCollection() {
        view.addSubview(favedBooksCollectionView)
        
        favedBooksCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        favedBooksCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        favedBooksCollectionView.widthAnchor.constraint(equalToConstant: 400 ),
//        favedBooksCollectionView.heightAnchor.constraint(equalToConstant: 250),
        favedBooksCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
        favedBooksCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

extension FavoriteVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favedBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let thisCell  = collectionView.dequeueReusableCell(withReuseIdentifier: "faveCell", for: indexPath) as? FavoriteBookCell else { return UICollectionViewCell()}
        let faveCell =  favedBooks[indexPath.row]
        let image = UIImage(data: faveCell.imageData)
        thisCell.weeksAtTop.text = "\(faveCell.weeksOn) week(s) on Bestseller"
        thisCell.bookSummary.text = faveCell.summary.description
        thisCell.faveBookImage.image = image
        thisCell.delegate = self
        thisCell.actionButton.tag = indexPath.row
        return thisCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 250)
    }
    
    
}

extension FavoriteVC: BookCellDelegate {
    
    func showActionSheet(tag: Int) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let destroyAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            try? BookPersistenceManager.manager.delete(element: self.favedBooks, atIndex: tag)
            self.loadData()
    
    }
        let buyFromAmazonAction = UIAlertAction(title: "Buy From Amazon", style: .destructive){(action) in
            if let url = URL(string: self.favedBooks[tag].amazonURL) {
                UIApplication.shared.open(url , options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(destroyAction)
        alert.addAction(buyFromAmazonAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    
    

}



