//
//  ViewController.swift
//  SocietyLibrary
//
//  Created by Tia Lendor on 10/18/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import UIKit

class BestsellersVC: UIViewController {
    
    let image = UIImage(named: "book")
    
    var category = String()
    
    var book = [Item]() //Imgage
    
    //Array of categories
    var bestBooks = [Category](){
        didSet{
            DispatchQueue.main.async {
                self.bookPicker.reloadAllComponents()
                
            }
        }
    }
    
    //Array of books
    var bestSeller = [BookElement](){
        didSet{
            DispatchQueue.main.async {
                self.booksCollectionView.reloadData()
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpDelegates()
        constrainBooksCollectionView()
        loadCategory() //Loads categories
        setUpConstraints()
    }
    
    private func setUpDelegates(){
        bookPicker.delegate = self
        bookPicker.dataSource = self
        
    }
    private func setUpView(){
        self.navigationItem.title = "NYT Bestsellers"
        view.backgroundColor = .white
    }
    lazy var bookPicker: UIPickerView = {
        let bookPicker = UIPickerView()
        return bookPicker
    }()
    lazy var booksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .lightGray
        cv.register(BestsellerBookCell.self, forCellWithReuseIdentifier: "bookCell")
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    //loads categorys
    func loadCategory(){
        BookCategoryAPIClient.manager.getCategory{ (result) in
            DispatchQueue.main.async {
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let arr):
                    DispatchQueue.main.async {
                        self.bestBooks = arr
                        
                    }
                }
            }
        }
    }
    //Loads books
    private func loadBestSellers() {
        BookImageApi.manager.getBestSellers(category: category) { (result) in
            DispatchQueue.main.async {
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let best):
                    DispatchQueue.main.async {
                        self.bestSeller = best
                    }
                    
                }
            }
        }
    }
    
    private func constrainBooksCollectionView(){
        view.addSubview(booksCollectionView)
        booksCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            booksCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            booksCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            booksCollectionView.heightAnchor.constraint(equalToConstant: 250),
            booksCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    private func constrainBooksPicker(){
        view.addSubview(bookPicker)
        bookPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bookPicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            bookPicker.heightAnchor.constraint(equalToConstant: 250),
            bookPicker.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    
    private func setUpConstraints(){
        constrainBooksCollectionView()
        constrainBooksPicker()
    }
}
extension BestsellersVC: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bestBooks.count
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let book =  bestBooks[row].display_name
        return book
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        category = bestBooks[row].list_name_encoded
        loadBestSellers()
    }
}
extension BestsellersVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bestSeller.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as? BestsellerBookCell else {return UICollectionViewCell()}
        let data = bestSeller[indexPath.row]

        
        ImageManager.manager.getImage(urlStr: data.book_image) { (result) in
            DispatchQueue.main.async {
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let image):
                    cell.bookImage.image = image
                }
            }
        }
        cell.bookName.text = data.title
        cell.bookText.text = data.description
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = BookDetailVC()
        let selectedBook = bestSeller[indexPath.row]

        detailVC.book = selectedBook
        detailVC.image = self.image

        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }}



