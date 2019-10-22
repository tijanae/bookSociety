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
        layout.scrollDirection = .horizontal
        let faveCV = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
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
//        favedBooksCollectionView.heightAnchor.constraint(equalToConstant: 250),
        favedBooksCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
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
        thisCell.weeksAtTop.text = "\(faveCell.weeksOn) weeks on Bestseller"
        thisCell.bookSummary.text = faveCell.summary
        return thisCell
    }
    
    
}



